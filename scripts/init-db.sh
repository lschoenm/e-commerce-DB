#!/usr/bin/env bash
set -euo pipefail

# Load .env for DB credentials
set -a
source .env
set +a

echo "Starting PostgreSQL via Docker Compose..."
docker compose up -d

echo "Waiting for PostgreSQL to become ready..."
until docker exec olist-postgres pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB" > /dev/null 2>&1; do
    printf "."
    sleep 1
done
echo "PostgreSQL is ready."

echo "Loading schema..."
docker exec -i olist-postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /sql/01-schema.sql

echo "Loading raw data..."
docker exec -i olist-postgres psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /sql/02-load-data.sql

echo "Database initialization complete."