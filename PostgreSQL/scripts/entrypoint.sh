#!/bin/bash
# entrypoint.sh

mkdir -p /mnt/logs/postgresql
chown -R postgres:postgres /mnt/logs/postgresql

sed -i "s/^#log_destination =.*$/log_destination='stderr'/g" /usr/share/postgresql/postgresql.conf.sample
sed -i 's/^#logging_collector =.*$/logging_collector = on/g' /usr/share/postgresql/postgresql.conf.sample
sed -i "s|^#log_directory =.*$|log_directory = '/mnt/logs/postgresql'|g" /usr/share/postgresql/postgresql.conf.sample

# chmod 700 /var/lib/postgresql -R
# su -c 'initdb -D /var/lib/postgresql/data' postgres

su -c "postgres -c config_file=/usr/share/postgresql/postgresql.conf.sample" postgres &

# # Lancer l'initialisation de la base de données (init_db.sh)
# if [ -f /docker-entrypoint-initdb.d/init_db.sh ]; then
#     echo "Exécution du script d'initialisation..."
#     /bin/bash /docker-entrypoint-initdb.d/init_db.sh
# fi

su -c "pg_ctl stop" postgres


# Lancer le processus par défaut de PostgreSQL (démarrer PostgreSQL)
exec docker-entrypoint.sh "$@"
