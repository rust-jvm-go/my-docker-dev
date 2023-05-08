#!/usr/bin/env bash
set -x
set -eo pipefail

docker compose -f ./docker-compose/dc-mongodb.yaml stop
