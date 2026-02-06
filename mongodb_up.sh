#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=./docker-compose/.env
COMPOSE_FILE=./docker-compose/dc-mongodb.yaml

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing env file: $ENV_FILE" >&2
  exit 1
fi

set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

: "${MONGODB_VOLUME_DIR:?MONGODB_VOLUME_DIR must be set in $ENV_FILE}"
mkdir -p "$MONGODB_VOLUME_DIR"

set -x
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" up -d
