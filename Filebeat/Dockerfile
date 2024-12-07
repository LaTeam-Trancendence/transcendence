FROM docker.elastic.co/beats/filebeat:8.16.1

# Créer un répertoire pour le fichier de configuration
USER root
WORKDIR /usr/share/filebeat/config

# Copier le fichier de configuration dans un emplacement accessible
COPY filebeat.yml .

# Donner les permissions nécessaires au fichier
RUN chmod 644 filebeat.yml && \
    chown root:root filebeat.yml

# Spécifier le chemin du fichier personnalisé lors du démarrage
ENTRYPOINT ["/usr/share/filebeat/filebeat", "-e", "-c", "/usr/share/filebeat/config/filebeat.yml"]
