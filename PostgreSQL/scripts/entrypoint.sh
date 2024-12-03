#!/bin/bash
# entrypoint.sh

# Lancer l'initialisation de la base de données (init_db.sh)
if [ -f /docker-entrypoint-initdb.d/init_db.sh ]; then
    echo "Exécution du script d'initialisation..."
    /bin/bash /docker-entrypoint-initdb.d/init_db.sh
fi

# Lancer le processus par défaut de PostgreSQL (démarrer PostgreSQL)
exec docker-entrypoint.sh "$@"
