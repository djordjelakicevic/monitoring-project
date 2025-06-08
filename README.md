# monitoring-project
This monitoring project includes: Linux / Debian 12 (WSL Windows), Prometheus, Node Exporter, Grafana, Alertmanager... 

WSL was installed on windows. 
Installed Debian and configured incus.
Configured Debian Containers (Grafana, Prometheus, Nginx).
Added node exporter to each container and host.
Configured Prometheus to scrape node exporters.
Imported Dashboard on grafana (Node Exporter Full).
Installed Nginx and set it up to serve as reverse proxy for Grafana and Prometheus.