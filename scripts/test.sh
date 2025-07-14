#!/bin/bash

# This script runs the PHPUnit tests for the WordPress plugin.

# Exit immediately if a command exits with a non-zero status.
set -e

# The container name is dynamic based on the instance ID in docker-compose.yml
# We need to find the running container name.
CONTAINER_NAME=$(docker-compose ps -q wordpress)

if [ -z "$CONTAINER_NAME" ]; then
    echo "WordPress container not found. Is the environment running? (docker-compose up -d)"
    exit 1
fi

echo "Running tests in container: $CONTAINER_NAME"

# Run the tests
docker exec "$CONTAINER_NAME" /var/www/html/vendor/bin/phpunit --configuration /var/www/html/phpunit.xml
