#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=./docker-compose/.env
COMPOSE_FILE=./docker-compose/dc-neo4j.yaml

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing env file: $ENV_FILE" >&2
  exit 1
fi

set -a
# shellcheck disable=SC1090
source "$ENV_FILE"
set +a

: "${NEO4J_VOLUME_DIR:?NEO4J_VOLUME_DIR must be set in $ENV_FILE}"
mkdir -p "$NEO4J_VOLUME_DIR"/data "$NEO4J_VOLUME_DIR"/logs "$NEO4J_VOLUME_DIR"/import "$NEO4J_VOLUME_DIR"/plugins

set -x
docker compose --env-file "$ENV_FILE" -f "$COMPOSE_FILE" up -d
