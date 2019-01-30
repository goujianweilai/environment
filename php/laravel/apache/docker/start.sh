#!/usr/bin/env bash

set -eux

role=${CONTAINER_ROLE:-app}
env=${APP_ENV:-production}

if [ "$env" = "production" ]; then

    echo "Caching configuration..."
    (cd /var/www/html && php artisan config:cache && php artisan route:cache && php artisan view:cache)

else

    echo "Clear Cache..."
    (cd /var/www/html && php artisan config:clear && php artisan route:clear && php artisan view:clear && php artisan cache:clear)

fi

if [ "$role" = "app" ]; then

    echo "Running apache..."
    exec apache2-foreground

elif [ "$role" = "horizon" ]; then

    echo "Running horizon..."
    php /var/www/html/artisan horizon

elif [ "$role" = "schedule" ]; then

    echo "Running schedule..."
    php /var/www/html/artisan schedule:run --verbose --no-interaction

else

    echo "Could not match the container role \"$role\""
    exit 1

fi
