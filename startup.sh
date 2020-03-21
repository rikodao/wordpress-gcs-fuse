#!/bin/sh
gcsfuse ca-oiso-wp  /var/www/html
docker-entrypoint.sh  apache2-foreground