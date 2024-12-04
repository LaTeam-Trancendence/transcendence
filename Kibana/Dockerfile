# Utilisation de l'image officielle Kibana
FROM docker.elastic.co/kibana/kibana:8.16.1

# Copie d'un fichier de configuration kibana.yml personnalisé
COPY kibana.yml /usr/share/kibana/config/kibana.yml

# Expose le port 5601 pour accéder à Kibana depuis le navigateur
EXPOSE 5601

# Lance Kibana avec le fichier de configuration modifié
CMD ["bin/kibana"]
