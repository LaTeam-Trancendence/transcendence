#!/bin/bash
# entrypoint.sh

mkdir -p /mnt/logs/postgresql
chown -R postgres:postgres /mnt/logs/postgresql

chown postgres:postgres /var/lib/postgresql -R
chmod 700 /var/lib/postgresql/data

echo "The server is already initialized : "
if [ -f /var/lib/postgresql/data/good ]
then
  echo "YES"
else
  echo "NO"
fi

sed -i "s/^#log_destination =.*$/log_destination='stderr'/g" /usr/share/postgresql/postgresql.conf.sample
sed -i 's/^#logging_collector =.*$/logging_collector = on/g' /usr/share/postgresql/postgresql.conf.sample
sed -i "s|^#log_directory =.*$|log_directory = '/mnt/logs/postgresql'|g" /usr/share/postgresql/postgresql.conf.sample

# Lancer le processus par défaut de PostgreSQL (démarrer PostgreSQL)
if [ ! -f /var/lib/postgresql/data/good ]
then
  su -c 'initdb -D /var/lib/postgresql/data --auth=trust' postgres || exit 42
  su -c '/docker-entrypoint-initdb.d/init_db.sh' postgres
  echo 'host    all             all             0.0.0.0/0            md5' >> /var/lib/postgresql/data/pg_hba.conf

  touch /var/lib/postgresql/data/good
fi
# su -c 'docker-entrypoint.sh' postgres


# echo "FIN DU CONTAINER"
exec gosu postgres "postgres" "-c" "config_file=/usr/share/postgresql/postgresql.conf.sample"
