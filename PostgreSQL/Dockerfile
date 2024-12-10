FROM postgres:16

EXPOSE 5432

# Copier le script d'initialisation et l'entrypoint
COPY ./scripts/init_db.sh /docker-entrypoint-initdb.d/
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/database_dump.sql /scripts/dump.sql

# Rendre les scripts exécutables
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh /entrypoint.sh

