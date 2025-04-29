#!/bin/bash

# Helper multi-commande pour le projet-4 (global, prod d'abord)

DOCKER_COMPOSE_FILE="_docker/docker-compose.yml"
DOCKER_COMPOSE_PROD_FILE="_docker/docker-compose.prod.yml"

show_help() {
  echo ""
  echo "🛠️  Helper Docker - projet-4 (global)"
  echo ""
  echo "Commandes disponibles :"
  echo "  prod-up            → Démarrer tous les services (production)"
  echo "  prod-down          → Arrêter tous les services (production)"
  echo "  prod-destroy       → Supprimer complètement tous les conteneurs (production)"
  echo "  prod-refresh       → Redémarrer tous les services (production)"
  echo "  up                 → Démarrer tous les services (développement)"
  echo "  down               → Arrêter tous les services (développement)"
  echo "  destroy            → Supprimer complètement tous les conteneurs (développement)"
  echo "  refresh            → Redémarrer tous les services (développement)"
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
  logs-php)
    echo "📜 Logs du conteneur projet-4-php"
    docker logs -f projet-4-php
    ;;
  logs-nginx)
    echo "📜 Logs du conteneur projet-4-nginx"
    docker logs -f projet-4-nginx
    ;;
  sh-php)
    docker exec -it projet-4-php sh
    ;;
  composer)
    docker exec -it projet-4-php composer "$@"
    ;;
  *)
    echo "❌ Commande inconnue: $COMMAND"
    show_help
    exit 1
    ;;
esac
