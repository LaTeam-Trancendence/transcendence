FROM postgres:16

EXPOSE 5432

# Copier le script d'initialisation et l'entrypoint
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./scripts/init_db.sh /docker-entrypoint-initdb.d/init_db.sh
COPY ./scripts/database_dump.sql /scripts/dump.sql

# Rendre les scripts exécutables
RUN chown postgres:postgres -R /docker-entrypoint-initdb.d/ ; \
	chmod 700 -R /docker-entrypoint-initdb.d/ /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
