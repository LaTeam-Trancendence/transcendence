#!/bin/bash

echo "Starting monthly GDPR anonymization task..."

# Exécute la commande Django pour anonymiser les utilisateurs
# python Backend_API/back/transcendance/manage.py anonymize_users
echo "Starting cron..." >> /mnt/log/api/cron.log
crond -l 2

echo "Monthly GDPR anonymization task completed."