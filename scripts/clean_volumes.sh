#!/bin/bash

NAME=transcendence
VOLUME="postgresql media prometheus grafana elasticsearch logstash/data logstash/logs filebeat logs"
VOLUME_DIR=${HOME}/${NAME}

for volume in $VOLUME;
do
	if [ -d "$VOLUME_DIR/$volume" ];
	then
		printf "Removing directory: $VOLUME_DIR/$volume\n";
		rm -rf "$VOLUME_DIR/$volume";
	else
		printf "Directory does not exist: $VOLUME_DIR/$volume\n";
	fi
done
