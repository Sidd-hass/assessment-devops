# Sourced by the other scripts. Loads .env (if present) and sets defaults.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
if [ -f .env ]; then set -a; . ./.env; set +a; fi
POSTGRES_USER="${POSTGRES_USER:-app}"
POSTGRES_DB="${POSTGRES_DB:-hotel}"
RESTORE_DB="${RESTORE_DB:-hotel_restore}"
BACKUP_DIR="${BACKUP_DIR:-backups}"
DC="docker compose"

require_db() {
  if ! $DC exec -T db pg_isready -U "$POSTGRES_USER" -d postgres >/dev/null 2>&1; then
    echo "ERROR: the 'db' service is not running/healthy. Start it with: docker compose up -d" >&2
    exit 1
  fi
}
