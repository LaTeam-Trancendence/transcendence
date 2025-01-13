#!/bin/bash

# Chemin du .env source
SOURCE_ENV="/home/$USER/sgoinfre/.env"

# Chemin du .env cible (à la racine)
TARGET_ENV="./.env"

# Vérifier si le fichier .env existe
if [ -f "$TARGET_ENV" ]; then
	echo "Le fichier .env existe déjà à la racine."
else
	echo "Le fichier .env est inexistant. Copie depuis $SOURCE_ENV..."
	if cp "$SOURCE_ENV" "$TARGET_ENV"; then
		echo "Le fichier .env a été copié avec succès."
	else
		echo "Erreur : Impossible de copier le fichier .env. Vérifiez les permissions ou le chemin source."
		exit 1
	fi
fi