#!/bin/sh
set -e

# Wait for Postgres and run migrations (the upstream entrypoint), without starting the app yet.
/docker-entrypoint.sh true

# On an empty database, start a temporary instance with sign-up enabled, create the admin
# from RYBBIT_ADMIN_EMAIL / RYBBIT_ADMIN_PASSWORD, and stop it again.
users=$(PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB" -tAc 'select count(*) from "user"')
if [ "$users" = "0" ] && [ -n "${RYBBIT_ADMIN_EMAIL:-}" ] && [ -n "${RYBBIT_ADMIN_PASSWORD:-}" ]; then
  DISABLE_SIGNUP=false node dist/cluster.js &
  pid=$!
  until wget -qO /dev/null http://127.0.0.1:3001/api/health 2>/dev/null; do
    kill -0 "$pid" 2>/dev/null || exit 1
    sleep 2
  done
  wget -qO /dev/null --header "Content-Type: application/json" --header "Origin: $BASE_URL" \
    --post-data "{\"email\":\"$RYBBIT_ADMIN_EMAIL\",\"password\":\"$RYBBIT_ADMIN_PASSWORD\",\"name\":\"Admin\"}" \
    http://127.0.0.1:3001/api/auth/sign-up/email \
    && echo "rybbit: admin $RYBBIT_ADMIN_EMAIL created"
  kill -TERM "$pid"
  wait "$pid" || true
fi

exec node dist/cluster.js
