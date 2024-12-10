FROM grafana/grafana:11.4.0

USER root

COPY ./provisioning /etc/grafana/provisioning
COPY ./dashboard.json /var/lib/grafana/dashboards/dashboard.json

RUN chmod -R 755 /etc/grafana/provisioning/dashboards/dashboard.yaml \
	/etc/grafana/provisioning/datasources/datasources.yaml \
	/var/lib/grafana/dashboards/dashboard.json