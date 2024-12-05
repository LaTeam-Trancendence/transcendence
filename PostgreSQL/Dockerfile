FROM postgres:16

EXPOSE 5432

# Copier le script d'initialisation et l'entrypoint
COPY ./scripts/init_db.sh /docker-entrypoint-initdb.d/
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/database_dump.sql /scripts/dump.sql

# Rendre les scripts exécutables
RUN chmod +x /docker-entrypoint-initdb.d/init_db.sh /entrypoint.sh

# Rediriger les logs vers stdout/stderr
RUN mkdir -p /var/log/postgresql/postgresql && \
	chmod -R 755 /var/log/postgresql && \
    ln -sf /dev/stdout /var/log/postgresql/postgresql/postgresql.log && \
    ln -sf /dev/stderr /var/log/postgresql/postgresql/postgresql_error.log
