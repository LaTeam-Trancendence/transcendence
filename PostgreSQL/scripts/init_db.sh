#!/bin/bash

# Vérifier que la base est accessible
echo "Waiting for the database to be ready..."
until psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

# Exécuter le fichier SQL
echo "Executing SQL script..."
echo "Databases : "$(psql -U postgres -lqt | cut -d \| -f 1 | grep "$POSTGRES_DATABASE")

if [ -z "$(psql -U postgres -lqt | cut -d '|' -f 1 | grep "$POSTGRES_DATABASE")" ]
then
	psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -f /scripts/dump.sql
fi

