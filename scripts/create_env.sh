#!/bin/bash
echo "Checking if .env exists..."

# Si le fichier .env n'existe pas, crée-le
if [ ! -f .env ]; then
  echo ".env file does not exist. Creating .env file..."
  touch .env
fi

# Demander des valeurs à l'utilisateur et ajouter au fichier .env
echo "Enter your database password:"
read DB_PASSWORD

echo "DB_PASSWORD=$DB_PASSWORD" >> .env

echo ".env file has been updated!"
