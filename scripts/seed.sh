#!/usr/bin/env bash
# Re-runs the seed file against the running database (it truncates first).
set -euo pipefail
# shellcheck source=scripts/_common.sh
. "$(dirname "$0")/_common.sh"
require_db
$DC exec -T db psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" -d "$POSTGRES_DB" < db/seed/seed.sql
