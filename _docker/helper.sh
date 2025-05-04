#!/bin/bash

# Helper multi-commande pour le messages-api (global, prod d'abord)

DOCKER_COMPOSE_FILE="_docker/docker-compose.yml"
DOCKER_COMPOSE_PROD_FILE="_docker/docker-compose.prod.yml"

show_help() {
  echo ""
  echo "🛠️  Helper Docker - messages-api (global)"
  echo ""
  echo "Commandes disponibles :"
  echo "  prod-up            → Démarrer tous les services (production)"
  echo "  prod-down          → Arrêter tous les services (production)"
  echo "  prod-destroy       → Supprimer complètement tous les conteneurs (production)"
  echo "  prod-refresh       → Redémarrer tous les services (production)"
  echo "  prod-restart       → Redémarrer tous les services (production)"
  echo "  up                 → Démarrer tous les services (développement)"
  echo "  down               → Arrêter tous les services (développement)"
  echo "  destroy            → Supprimer complètement tous les conteneurs (développement)"
  echo "  refresh            → Redémarrer tous les services (développement)"
  echo "  restart            → Redémarrer tous les services (développement)"
  echo "  logs-php           → Afficher les logs du conteneur PHP"
  echo "  logs-nginx         → Afficher les logs du conteneur Nginx"
  echo "  sh-php             → Accès shell dans le conteneur PHP"
  echo "  composer [...]     → Lancer Composer dans le conteneur PHP"
}

if [ $# -lt 1 ]; then
  show_help
  exit 0
fi

COMMAND=$1
shift

case "$COMMAND" in
  prod-up)
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" up -d
    ;;
  prod-down)
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" down
    ;;
  prod-destroy)
    echo "❗ Suppression complète des services en production"
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" down --volumes --remove-orphans
    ;;
  prod-refresh)
    echo "🔄 Redémarrage complet des services en production"
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" down
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" up -d --build
    ;;
  prod-restart)
    echo "🔄 Redémarrage des services en production"
    docker compose -f "$DOCKER_COMPOSE_PROD_FILE" restart
    ;;
  up)
    docker compose -f "$DOCKER_COMPOSE_FILE" up -d
    ;;
  down)
    docker compose -f "$DOCKER_COMPOSE_FILE" down
    ;;
  destroy)
    echo "❗ Suppression complète des services en développement"
    docker compose -f "$DOCKER_COMPOSE_FILE" down --volumes --remove-orphans
    ;;
  refresh)
    echo "🔄 Redémarrage complet des services en développement"
    docker compose -f "$DOCKER_COMPOSE_FILE" down
    docker compose -f "$DOCKER_COMPOSE_FILE" up -d --build
    ;;
  restart)
    echo "🔄 Redémarrage des services en développement"
    docker compose -f "$DOCKER_COMPOSE_FILE" restart
    ;;
  logs-php)
    echo "📜 Logs du conteneur messages-api-php"
    docker logs -f messages-api-php
    ;;
  logs-nginx)
    echo "📜 Logs du conteneur messages-api-nginx"
    docker logs -f messages-api-nginx
    ;;
  sh-php)
    docker exec -it messages-api-php sh
    ;;
  composer)
    docker exec -it messages-api-php composer "$@"
    ;;
  *)
    echo "❌ Commande inconnue: $COMMAND"
    show_help
    exit 1
    ;;
esac
