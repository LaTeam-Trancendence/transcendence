# Utiliser l'image officielle de Prometheus
FROM prom/prometheus:latest

# Copier les fichier de configuration
COPY ./prometheus.yml /etc/prometheus/prometheus.yml
COPY ./alert.rules /etc/prometheus/alert.rules
COPY ./test_alert.rules /etc/prometheus/test_alert.rules

# Exposer le port 9090 pour accéder à l'interface de Prometheus
EXPOSE 9090

# Démarrer Prometheus avec le fichier de configuration spécifié
CMD [ "--config.file=/etc/prometheus/prometheus.yml" ]
