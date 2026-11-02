#!/usr/bin/env bash
# Compares the source DB and the restored DB (row counts, amount totals, content checksums).
set -euo pipefail
# shellcheck source=scripts/_common.sh
. "$(dirname "$0")/_common.sh"
require_db

SQL="SELECT
  (SELECT COUNT(*) FROM hotel_bookings),
  (SELECT COUNT(*) FROM booking_events),
  (SELECT COALESCE(SUM(amount),0) FROM hotel_bookings),
  (SELECT md5(string_agg(b::text, '|' ORDER BY id)) FROM hotel_bookings b),
  (SELECT md5(string_agg(e::text, '|' ORDER BY id)) FROM booking_events e),
  (SELECT COUNT(*) FROM pg_indexes WHERE tablename IN ('hotel_bookings','booking_events'));"

q() { $DC exec -T db psql -U "$POSTGRES_USER" -d "$1" -At -c "$SQL"; }

SRC="$(q "$POSTGRES_DB")"
DST="$(q "$RESTORE_DB")"
echo "source  ($POSTGRES_DB): $SRC"
echo "restore ($RESTORE_DB): $DST"
if [ "$SRC" = "$DST" ]; then echo "PASS: restored database matches the source."; else echo "FAIL: mismatch" >&2; exit 1; fi
