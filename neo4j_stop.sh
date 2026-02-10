#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=./docker-compose/.env
COMPOSE_FILE=./docker-compose/dc-neo4j.yaml

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing env file: $ENV_FILE" >&2
  exit 1
fi

set -x
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" stop
