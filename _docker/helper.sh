#!/bin/bash

# Helper multi-commande pour le projet-4
# Usage :
#   ./_docker/helper.sh composer [args...]   => composer install, require, etc.
#   ./_docker/helper.sh sh                   => accès au shell du conteneur PHP

DOCKER_COMPOSE_FILE="_docker/docker-compose.yml"
SERVICE_NAME="php"

if [ $# -lt 1 ]; then
  echo "Usage:"
  echo "  $0 composer [args...]"
  echo "  $0 sh"
  exit 1
fi

COMMAND=$1
shift

case "$COMMAND" in
  composer)
    docker compose -f "$DOCKER_COMPOSE_FILE" exec "$SERVICE_NAME" composer "$@"
    ;;
  sh)
    docker compose -f "$DOCKER_COMPOSE_FILE" exec "$SERVICE_NAME" sh
    ;;
  *)
    echo "Commande inconnue: $COMMAND"
    exit 1
    ;;
esac
