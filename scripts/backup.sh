#!/usr/bin/env bash
# Creates a timestamped pg_dump (custom format) of the source database in ./backups
set -euo pipefail
# shellcheck source=scripts/_common.sh
. "$(dirname "$0")/_common.sh"
require_db

mkdir -p "$BACKUP_DIR"
TS="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="$BACKUP_DIR/${POSTGRES_DB}_${TS}.dump"
TMP="$OUT.partial"
trap 'rm -f "$TMP"' EXIT

echo "Backing up '$POSTGRES_DB' -> $OUT"
$DC exec -T db pg_dump -U "$POSTGRES_USER" -d "$POSTGRES_DB" --format=custom --no-owner > "$TMP"

# Sanity check: the archive must be readable and non-empty
$DC exec -T db pg_restore --list < "$TMP" >/dev/null
mv "$TMP" "$OUT"
trap - EXIT
echo "Done: $OUT ($(du -h "$OUT" | cut -f1))"
