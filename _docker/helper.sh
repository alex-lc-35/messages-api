#!/bin/bash

# Helper multi-commande pour le projet messages-api

DOCKER_COMPOSE_FILE="_docker/docker-compose.yml"
DOCKER_COMPOSE_PROD_FILE="_docker/docker-compose.prod.yml"

PHP_CONTAINER="messages-api-php"
NGINX_CONTAINER="messages-api-nginx"

show_help() {
  echo ""
  echo "🛠️  Helper Docker - messages-api"
  echo ""
  echo "Commandes disponibles :"
  echo "  prod-up            → Démarrer les services (production)"
  echo "  prod-down          → Arrêter les services (production)"
  echo "  prod-destroy       → Supprimer complètement les conteneurs (production)"
  echo "  prod-refresh       → Redémarrer complètement les services (production)"
  echo "  prod-restart       → Redémarrer les services (production)"
  echo "  up                 → Démarrer les services (développement)"
  echo "  down               → Arrêter les services (développement)"
  echo "  destroy            → Supprimer complètement les conteneurs (développement)"
  echo "  refresh            → Redémarrer complètement les services (développement)"
  echo "  restart            → Redémarrer les services (développement)"
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
    echo "📜 Logs de $PHP_CONTAINER"
    docker logs -f "$PHP_CONTAINER"
    ;;
  logs-nginx)
    echo "📜 Logs de $NGINX_CONTAINER"
    docker logs -f "$NGINX_CONTAINER"
    ;;
  sh-php)
    docker exec -it "$PHP_CONTAINER" sh
    ;;
  composer)
    docker exec -it "$PHP_CONTAINER" composer "$@"
    ;;
  *)
    echo "❌ Commande inconnue: $COMMAND"
    show_help
    exit 1
    ;;
esac
