#!/bin/bash
# entrypoint.sh

mkdir -p /mnt/logs/postgresql
chown -R postgres:postgres /mnt/logs/postgresql

sed -i "s/^#log_destination =.*$/log_destination='stderr'/g" /usr/share/postgresql/postgresql.conf.sample
sed -i 's/^#logging_collector =.*$/logging_collector = on/g' /usr/share/postgresql/postgresql.conf.sample
sed -i "s|^#log_directory =.*$|log_directory = '/mnt/logs/postgresql'|g" /usr/share/postgresql/postgresql.conf.sample

# Lancer le processus par défaut de PostgreSQL (démarrer PostgreSQL)
su -c 'initdb -D /var/lib/postgresql/data' postgres
su -c '/docker-entrypoint-initdb.d/init_db.sh' postgres
# su -c 'docker-entrypoint.sh' postgres

# echo "FIN DU CONTAINER"
exec gosu postgres "postgres" "-c" "config_file=/usr/share/postgresql/postgresql.conf.sample"
