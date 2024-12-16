# Image official Nginx
FROM nginx

RUN apt update ; apt install -y bash

# Créer les dossiers nécessaires pour les certificats et les logs
RUN mkdir -p /etc/ssl/private && \
    chmod 700 /etc/ssl/private

# Générer un certificat auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=FR/ST=LeHavre/L=LeHavre/O=42/OU=42/CN=${HOSTNAME}"
RUN chown -R nginx:nginx /etc/ssl/private

# Copier le fichier de configuration personnalisé
COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port 8443 pour HTTPS
EXPOSE 8443

# Lancer Nginx en mode premier plan
CMD [ "sh", "-c", "mkdir -p /mnt/logs/nginx ; exec nginx -g 'daemon off;' >/mnt/logs/nginx/access.log 2>/mnt/logs/nginx/error.log" ]
