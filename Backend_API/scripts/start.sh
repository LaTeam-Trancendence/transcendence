#!/bin/bash

# Appliquer les migrations Django
echo "Applying database migrations..."
python manage.py migrate --noinput
# python manage.py loaddata data_final

# Cree les dossiers /mnt, /mnt/logs et /mnt/logs/api s'ils n'existent pas.
mkdir -p /mnt/logs/api

# Lancer Gunicorn pour servir l'application Django
echo "Starting Gunicorn server..."
exec python3 -m gunicorn Back.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --access-logfile /mnt/logs/api/access.log \
    --error-logfile /mnt/logs/api/error.log
