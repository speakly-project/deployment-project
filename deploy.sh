#!/bin/bash
ENTORNO=$1

# Verificar que se pasó parámetro
if [ -z "$ENTORNO" ]; then
    echo "Error: Falta parámetro"
    echo "Uso: $0 [preprod|prod]"
    exit 1
fi

# Validar parámetro
if [ "$ENTORNO" != "preprod" ] && [ "$ENTORNO" != "prod" ]; then
    echo "Error: Parámetro debe ser 'preprod' o 'prod'"
    exit 1
fi

docker compose down --remove-orphans --env-file "environments/.env.$ENTORNO" 
docker compose build --no-cache --env-file "environments/.env.$ENTORNO"
docker compose --env-file "environments/.env.$ENTORNO" up -d