#!/bin/bash

### VARS ###
DOWNLOAD_LINK="https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz"
FILENAME=$(basename "$DOWNLOAD_LINK")
FOLDER_NAME="${FILENAME%.tar.gz}"
USER="node_exporter"
SERVICE_PATH="/etc/systemd/system/node_exporter.service"
SOCKET_PATH="/etc/systemd/system/node_exporter.socket"

### Clean previous downloads ###
rm -rf node_exporter* || echo -e "\n\n There is no previous downloads, contineing..."

### Function for handling errors ###
handle_error() {
  echo "Error: $1"
  exit 1
}


### Check if wget command is installed ###
if ! command -v wget &> /dev/null; then
  echo "---> wget command is not installed. Installing... <---"
  apt update
  apt install -y wget && echo "---> wget command installed. <---" || handle_error "---> Installing wget failed.. <---"
fi

### Downloading node_exporter ###
wget "$DOWNLOAD_LINK" && echo "---> Download finished. <---" || handle_error "---> Failed to download from '$DOWNLOAD_LINK'. <---"

tar -xzvf "$FILENAME"
mv "$FOLDER_NAME"/"$USER" /usr/bin/
useradd -rs /sbin/nologin "$USER"

### Check if joe command is installed ###
if ! command -v joe &> /dev/null; then
  echo "---> Joe is not installed. Installing... <---"
  apt update
  apt install -y joe && echo "---> joe command installed. <---" || handle error "---> Installing joe failed. <---"
fi

### Creating service file ###
tee "$SERVICE_PATH" > /dev/null <<EOF
[Unit]
Description=Node Exporter
Requires=node_exporter.socket

[Service]
User=node_exporter
# Fallback when environment file does not exist
Environment=OPTIONS=
EnvironmentFile=-/etc/node_exporter
ExecStart=/usr/bin/node_exporter --web.systemd-socket \$OPTIONS

[Install]
WantedBy=multi-user.target
EOF

echo "---> Systemd servis fajl je upisan u $SERVICE_PATH. <---"

### Creating socket file ###
tee "$SOCKET_PATH" > /dev/null <<EOF
[Unit]
Description=Node Exporter

[Socket]
ListenStream=9100

[Install]
WantedBy=sockets.target
EOF

mkdir -p /var/lib/"$USER"
echo '"OPTIONS="--collector.textfile.directory /var/lib/node_exporter/textfile_collector' > /var/lib/"$USER"/textfile_collector

echo "---> Socket file written in $SOCKET_PATH. <---"
chown -R "$USER":"$USER" /var/lib/"$USER"

systemctl daemon-reload
systemctl enable --now "$USER".service &&
echo "---> Node exporter is installed successfully and now listening on port 9100. <---" ||
handle_error "---> There is some error. Please check. <---"