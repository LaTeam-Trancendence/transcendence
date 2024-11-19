#!/bin/bash

echo "Starting monthly GDPR anonymization task..."

# Exécute la commande Django pour anonymiser les utilisateurs
python /app/manage.py anonymize_users

echo "Monthly GDPR anonymization task completed."
