#!/bin/bash

# Appliquer les migrations Django
echo "Applying database migrations..."
python manage.py migrate --noinput
python manage.py loaddata data_final

# Lancer Gunicorn pour servir l'application Django
echo "Starting Gunicorn server..."
exec python3 -m gunicorn Back.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3