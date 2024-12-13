# Build stage
FROM node:18-alpine as build-stage

# Installer les dépendances nécessaires pour la construction
RUN apk add --no-cache curl

WORKDIR /app

COPY front_transcendence/package.json ./
RUN npm install

COPY front_transcendence/ ./
RUN npm run build



# Production stage
FROM nginx:stable-alpine as production-stage

# Copier les fichiers construits dans le répertoire public de Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Configurer les logs
# RUN mkdir -p /mnt/logs/frontend && \
#     chmod -R 755 /mnt/logs/frontend

# Exposer le port 80
EXPOSE 80

# Commande pour démarrer Nginx
# CMD [ "sh", "-c", "mkdir -p /mnt/logs/ && exec nginx -g 'daemon off;' >/mnt/logs/frontend/access.log 2>/mnt/logs/frontend/error.log" ]
CMD [ "sh", "-c", "mkdir -p /mnt/logs/frontend && exec nginx -g 'daemon off;' > /mnt/logs/frontend/access.log 2> /mnt/logs/frontend/error.log" ]