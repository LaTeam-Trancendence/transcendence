#!/bin/bash

echo "Starting monthly GDPR anonymization task..."

echo "Starting cron..." >> /mnt/logs/api/cron.log
crond -l 2

echo "Monthly GDPR anonymization task completed."