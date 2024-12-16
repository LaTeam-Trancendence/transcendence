FROM grafana/grafana:11.4.0

USER root

RUN sed -i 's|^;root_url = %(protocol)s://%(domain)s:%(http_port)s/$|root_url = https://localhost:8443/grafana|g' /etc/grafana/grafana.ini
RUN sed -i 's|^;serve_from_sub_path = false$|serve_from_sub_path = true|g' /etc/grafana/grafana.ini
RUN cat /etc/grafana/grafana.ini

COPY ./provisioning /etc/grafana/provisioning
COPY ./dashboard.json /var/lib/grafana/dashboards/dashboard.json

RUN chmod -R 755 /etc/grafana/provisioning/dashboards/dashboard.yaml \
	/etc/grafana/provisioning/datasources/datasources.yaml \
	/var/lib/grafana/dashboards/dashboard.json
