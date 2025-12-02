#!/usr/bin/env bash
set -euo pipefail

docker compose down -v

echo "Database shut down and deleted."