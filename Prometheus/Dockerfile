# Utiliser l'image officielle de Prometheus
FROM prom/prometheus:latest
# Copier le fichier de configuration personnalisé dans le conteneur
COPY ./prometheus.yml /etc/prometheus/prometheus.yml

# Exposer le port 9090 pour accéder à l'interface de Prometheus
EXPOSE 9090

# Démarrer Prometheus avec le fichier de configuration spécifié
CMD [ "--config.file=/etc/prometheus/prometheus.yml" ]
