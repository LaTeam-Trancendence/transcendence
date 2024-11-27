FROM python:3.11-alpine

# Installer les dépendances nécessaires pour PostgreSQL
RUN apk add --no-cache \
	build-base \
	linux-headers \
	libffi-dev \
	postgresql-dev \
	postgresql-client \
	musl-dev \
	bash \
	dcron \
	py3-django \
	py3-gunicorn

# Copier le fichier SQL dans l'image
# COPY ./back/database_dump.sql /docker-entrypoint-initdb.d/init.sql

COPY . /app

COPY scripts/test.py /app/test.py

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers et installer les dépendances Python
COPY ./scripts /app/scripts
RUN chmod +x /app/scripts/*.sh

# Mettre à jour pip et installer les dépendances Python
RUN pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir -r requirements.txt

COPY ./scripts/root /etc/crontabs/root
# Give execution rights on the cron job
RUN chmod 0755 /etc/crontabs/root
# Create the log file
RUN touch /var/log/cron.log

# Exposer le port 8000
EXPOSE 8000

# Lancer le cron avec le serveur
CMD ["sh", "-c", "/app/scripts/cron.sh & /app/scripts/start.sh"]
