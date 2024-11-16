# Image official Nginx
FROM nginx

# ARG HOSTNAME=localhost
# ENV HOSTNAME=${HOSTNAME}

# ARG API_PORT=8000
# ENV API_PORT=${API_PORT}

RUN mkdir -p /etc/ssl/private
RUN chmod 700 /etc/ssl/private
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
CMD ["nginx", "-g", "daemon off;"]