#!/bin/bash

NAME=transcendence
VOLUME="postgresql media prometheus grafana elasticsearch logstash/data logstash/logs filebeat logs"
VOLUME_DIR=${HOME}/${NAME}

for volume in $VOLUME; do
	if [ ! -d "$VOLUME_DIR/$volume" ]; then
		printf "Creating directory: $VOLUME_DIR/$volume\n";
		mkdir -p "$VOLUME_DIR/$volume";
	else
		printf "Directory already exists: $VOLUME_DIR/$volume\n";
	fi
done
