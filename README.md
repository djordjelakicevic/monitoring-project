# 🖥️ Monitoring Project

A simple monitoring setup using **Linux (Debian 12 on WSL)**, **Prometheus**, **Node Exporter**, **Grafana**, **Alertmanager**, and **Nginx**.

---

## 🔧 Stack Overview

- **Host OS:** Windows (with WSL)
- **Linux Distro:** Debian 12
- **Containers:** Managed using [Incus]
- **Monitoring Tools:**
  - Prometheus
  - Node Exporter
  - Grafana 
  - Alertmanager
- **Reverse Proxy:** Nginx

---

## 📦 What This Project Includes

- ✅ Installation and configuration of **WSL** with **Debian 12**
- ✅ Setup and configuration of **Incus containers** (Grafana, Prometheus, Nginx)
- ✅ **Node Exporter** installed on host and all containers
- ✅ **Prometheus** configured to scrape metrics from all exporters
- ✅ **Grafana** with imported **Node Exporter Full** dashboard
- ✅ **NGINX** configured as a reverse proxy for Prometheus and Grafana

---