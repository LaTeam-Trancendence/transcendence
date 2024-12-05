FROM python:3.11-alpine

# Installer les dépendances nécessaires pour PostgreSQL
RUN apk add --no-cache \
    build-base \
    linux-headers \
    libffi-dev \
    postgresql-dev \
    postgresql-client \
    musl-dev \
    libpq-dev \
    gcc \
    bash \
    dcron \
	wget


COPY . /app

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers et installer les dépendances Python
COPY ./scripts /app/scripts
RUN chmod +x /app/scripts/*.sh

# Mettre à jour pip et installer les dépendances Python
RUN python3 -m pip install --break-system-packages --no-cache-dir --upgrade pip && \
    python3 -m pip install --break-system-packages --no-cache-dir gunicorn && \
    python3 -m pip install --break-system-packages --no-cache-dir -r requirements.txt

# Configurer les tâches cron
COPY ./scripts/root /etc/crontabs/root
RUN chmod 0755 /etc/crontabs/root
RUN touch /var/log/cron.log

# Créer le répertoire des logs API
RUN mkdir -p /var/log/api/api && \
    chmod -R 755 /var/log/api

# Exposer le port 8000
EXPOSE 8000

# Lancer le cron avec le serveur et rediriger les logs
CMD ["sh", "-c", "/app/scripts/cron.sh >> /var/log/api/api/cron.log 2>&1 & /app/scripts/start.sh >> /var/log/api/api/api.log 2>&1"]
