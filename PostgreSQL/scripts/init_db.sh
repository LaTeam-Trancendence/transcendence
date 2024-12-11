#!/bin/bash

echo "Databases : "$(psql -U postgres -lqt | cut -d \| -f 1 | grep "$POSTGRES_DATABASE")

# Exécuter le fichier SQL si la db n'existe pas
if [ -z "$(psql -U postgres -lqt | cut -d '|' -f 1 | grep "$POSTGRES_DATABASE")" ]
then
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
  echo 'host    all             all             0.0.0.0/0            md5' >> /var/lib/postgresql/data/pg_hba.conf
fi
