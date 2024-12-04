FROM postgres:16

EXPOSE 5432

# Copier le script d'initialisation et l'entrypoint
COPY ./scripts/init_db.sh /docker-entrypoint-initdb.d/
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/database_dump.sql /scripts/dump.sql
RUN chmod +x /entrypoint.sh
