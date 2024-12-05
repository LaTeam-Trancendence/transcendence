# Image official Nginx
FROM nginx

# Créer les dossiers nécessaires pour les certificats et les logs
RUN mkdir -p /etc/ssl/private /var/log/nginx && \
    chmod 700 /etc/ssl/private && \
    chmod 755 /var/log/nginx

# Générer un certificat auto-signé
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=FR/ST=LeHavre/L=LeHavre/O=42/OU=42/CN=${HOSTNAME}"
RUN chown -R nginx:nginx /etc/ssl/private

# Copier le fichier de configuration personnalisé
COPY nginx.conf /etc/nginx/nginx.conf

# Configurer les logs pour qu'ils soient redirigés vers stdout/stderr
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Exposer le port 8443 pour HTTPS
EXPOSE 8443

# Lancer Nginx en mode premier plan
CMD ["nginx", "-g", "daemon off;"]