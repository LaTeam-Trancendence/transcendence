# Utiliser l'image officielle de Logstash
FROM docker.elastic.co/logstash/logstash:8.16.1

# Passer en tant qu'utilisateur root pour gérer les fichiers
USER root

# Créer un répertoire pour les fichiers de configuration
WORKDIR /usr/share/logstash/config

# Copier le fichier logstash.conf dans le conteneur
COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf

# Assurer les permissions nécessaires pour le fichier de configuration
RUN chmod 644 /usr/share/logstash/pipeline/logstash.conf && \
    chown logstash:logstash /usr/share/logstash/pipeline/logstash.conf

# Commande d'entrée pour démarrer Logstash avec la configuration personnalisée
ENTRYPOINT ["/usr/share/logstash/bin/logstash", "-f", "/usr/share/logstash/pipeline/logstash.conf"]
