#!/bin/bash

# Appliquer les migrations Django
echo "Applying database migrations..."
#python manage.py migrate --noinput

# Lancer Gunicorn pour servir l'application Django
echo "Starting Gunicorn server..."
 pip install --no-cache-dir -r requirements.txt
exec gunicorn Back.wsgi:application \
	--bind 0.0.0.0:8000 \
	--workers 3