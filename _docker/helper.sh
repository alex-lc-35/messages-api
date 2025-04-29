#!/bin/bash

# Helper multi-commande pour le projet-4 (PHP / Composer)

DOCKER_COMPOSE_FILE="_docker/docker-compose.yml"
DOCKER_COMPOSE_PROD_FILE="_docker/docker-compose.prod.yml"
SERVICE_NAME="php"

show_help() {
  echo ""
  echo "🛠️  Helper Docker - projet-4"
  echo ""
  echo "DB"
  echo "migrate"
  echo ""
  echo "Commandes disponibles :"
  echo "  up                → Démarrer les services (développement)"
  echo "  down              → Arrêter les services (développement)"
  echo "  up-prod           → Démarrer les services (production)"
  echo "  down-prod         → Arrêter les services (production)"
  echo "  logs              → Afficher les logs"
  echo "  log-php           → Afficher uniquement les logs du conteneur PHP"
  echo "  sh                → Accès shell dans le conteneur PHP"
  echo "  composer [...]    → Lancer Composer avec les arguments donnés"
}

if [ $# -lt 1 ]; then
  show_help
  exit 0
fi

COMMAND=$1
shift

case "$COMMAND" in
  migrate)
    docker compose -f "$DOCKER_COMPOSE_FILE" exec "$SERVICE_NAME" php database/migrate.php
    ;;

  up)
    docker compose -f "$DOCKER_COMPOSE_FILE" up -d
    ;;
  down)
    docker compose -f "$DOCKER_COMPOSE_FILE" down
    ;;
  up-prod)
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" up -d
    ;;
  down-prod)
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" down
    ;;
  logs)
    docker compose -f "$DOCKER_COMPOSE_FILE" logs -f
    ;;
  log-php)
    docker compose -f "$DOCKER_COMPOSE_FILE" logs -f "$SERVICE_NAME"
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
