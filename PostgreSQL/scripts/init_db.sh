#!/bin/bash

# Exécuter le fichier SQL si la db n'existe pas
echo "Executing SQL script..."
pg_ctl start

# Vérifier que la base est accessible
echo "Waiting for the database to be ready..."
until psql -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 2
done

psql -f /scripts/dump.sql
pg_ctl stop
