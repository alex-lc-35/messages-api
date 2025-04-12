#!/bin/bash

# Helper multi-commande pour le projet-4 (PHP / Composer)

DOCKER_COMPOSE_FILE="_docker/docker-compose.yml"
SERVICE_NAME="php"

show_help() {
  echo ""
  echo "🛠️  Helper Docker - projet-4"
  echo ""
  echo "Commandes disponibles :"
  echo "  up                → Démarrer les services"
  echo "  down              → Arrêter les services"
  echo "  logs              → Afficher les logs"
  echo "  sh                → Accès shell dans le conteneur PHP"
  echo "  composer [...]    → Lancer Composer avec les arguments donnés"
  echo ""
  echo "Exemples :"
  echo "  ./_docker/helper.sh up"
  echo "  ./_docker/helper.sh composer install"
  echo ""
}

if [ $# -lt 1 ]; then
  show_help
  exit 0
fi

COMMAND=$1
shift

case "$COMMAND" in
  up)
    docker compose -f "$DOCKER_COMPOSE_FILE" up -d
    ;;
  down)
    docker compose -f "$DOCKER_COMPOSE_FILE" down
    ;;
  logs)
    docker compose -f "$DOCKER_COMPOSE_FILE" logs -f
    ;;
  sh)
    docker compose -f "$DOCKER_COMPOSE_FILE" exec "$SERVICE_NAME" sh
    ;;
  composer)
    docker compose -f "$DOCKER_COMPOSE_FILE" exec "$SERVICE_NAME" composer "$@"
    ;;
  *)
    echo "❌ Commande inconnue: $COMMAND"
    show_help
    exit 1
    ;;
esac
