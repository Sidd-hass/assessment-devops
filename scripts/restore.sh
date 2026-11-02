#!/usr/bin/env bash
# Restores a dump into a FRESH database ($RESTORE_DB, default hotel_restore).
# Usage: ./scripts/restore.sh [path/to/file.dump]   (default: newest file in ./backups)
set -euo pipefail
# shellcheck source=scripts/_common.sh
. "$(dirname "$0")/_common.sh"
require_db

FILE="${1:-$(ls -1t "$BACKUP_DIR"/*.dump 2>/dev/null | head -n1 || true)}"
if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
  echo "ERROR: no backup file found. Run ./scripts/backup.sh first or pass a path." >&2
  exit 1
fi
if [ "$RESTORE_DB" = "$POSTGRES_DB" ]; then
  echo "ERROR: RESTORE_DB must differ from POSTGRES_DB ($POSTGRES_DB)." >&2
  exit 1
fi

psql_admin() { $DC exec -T db psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d postgres "$@"; }

echo "Recreating database '$RESTORE_DB'"
psql_admin -c "DROP DATABASE IF EXISTS \"$RESTORE_DB\" WITH (FORCE);"
psql_admin -c "CREATE DATABASE \"$RESTORE_DB\";"

echo "Restoring $FILE -> $RESTORE_DB"
$DC exec -T db pg_restore -U "$POSTGRES_USER" -d "$RESTORE_DB" --no-owner --exit-on-error < "$FILE"

echo "Row counts in '$RESTORE_DB':"
$DC exec -T db psql -U "$POSTGRES_USER" -d "$RESTORE_DB" -c \
  "SELECT 'hotel_bookings' AS table_name, COUNT(*) FROM hotel_bookings
   UNION ALL SELECT 'booking_events', COUNT(*) FROM booking_events;"
echo "Restore complete. Run ./scripts/verify_restore.sh to compare with the source."
