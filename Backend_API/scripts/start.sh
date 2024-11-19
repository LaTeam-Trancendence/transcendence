#!/bin/bash

# Appliquer les migrations Django
echo "Applying database migrations..."
python manage.py migrate --noinput

# Lancer Gunicorn pour servir l'application Django
echo "Starting Gunicorn server..."
exec gunicorn my_django_project.wsgi:application \
	--bind 0.0.0.0:8000 \
	--workers 3