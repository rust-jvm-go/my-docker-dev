#!/usr/bin/env bash
set -x
set -eo pipefail

docker compose -f ./docker-compose/dc-nats-single.yaml up -d
