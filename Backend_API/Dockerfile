FROM alpine:latest

RUN apk upgrade && apk update
RUN apk add --no-cache \
	python3 \
	py3-pip \
	build-base \
	linux-headers \
	libffi-dev \
	postgresql-dev \
	postgresql-client \
	musl-dev \
	bash \
	dcron
# Python 3, nécessaire pour exécuter Django et les autres scripts Python.
# Py3-pip, nécessaire pour installer les dépendances Python.
# Build-base installe un ensemble d'outils de compilation essentiels
# Linux-headers compiler des bibliothèques natives qui interagissent
				#avec le noyau Linux
# Libffi-dev permet d'utiliser des extensions Python reliant du code C,
				# comme pour le chiffrement
# Postgresql-dev nécessaires pour interagir avec une BD (base de donnee) PostgreSQL
# Postgresql-client nécessaire pour exécuter des commandes SQL sur une BD PostgreSQL
# Musl-dev Requis par les compilateurs et certains modules Python
			#pour interagir avec le système sous-jacent
# Bash, nécessaire pour exécuter les scripts Bash.
# Dcron, nécessaire pour exécuter les tâches cron.

# Copier le fichier SQL dans l'image
COPY ./database_dump.sql /docker-entrypoint-initdb.d/init.sql
# # Commande pour exécuter le fichier SQL après que le conteneur démarre
# RUN psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DB \
# 	-f /docker-entrypoint-initdb.d/init.sql

# Définir le répertoire de travail
WORKDIR /app
# Copier les dépendances Python, le projet Django et les scripts dans l'image
COPY requirements.txt /app/
COPY ./<django_project> /app
COPY ./scripts /scripts
RUN chmod +x /scripts/*.sh

# Mettre à jour pip et installer Django, Gunicorn, et psycopg2
# et les dépendances Python
RUN pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir django gunicorn psycopg2-binary \
	pip install --no-cache-dir -r requirements.txt

# Configurer Cron
COPY ./scripts/crontab /etc/crontabs/root

# Exposer le port 8000
EXPOSE 8000

# Configurer et lancer le cron avec le serveur
CMD ["sh", "-c", "crond && /scripts/start.sh"]
