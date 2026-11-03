#!/usr/bin/env bash
# Shows the query plan for the optimized query.
set -euo pipefail
# shellcheck source=scripts/_common.sh
. "$(dirname "$0")/_common.sh"
require_db
$DC exec -T db psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" <<'SQL'
VACUUM (ANALYZE) hotel_bookings;
EXPLAIN (ANALYZE, BUFFERS)
SELECT org_id, status, COUNT(*), SUM(amount)
FROM hotel_bookings
WHERE city = 'delhi'
  AND created_at >= NOW() - INTERVAL '30 days'
GROUP BY org_id, status;
SQL
