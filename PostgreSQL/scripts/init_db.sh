#!/bin/bash

# Vérifier que la base est accessible
echo "Waiting for the database to be ready..."
until psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

# Exécuter le fichier SQL
echo "Executing SQL script..."
if [ ! psql -lqt | cut -d \| -f 1 | grep -qw "$POSTGRES_DB" ]
then
	psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /scripts/database_dump.sql
fi

