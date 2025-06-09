#!/bin/bash
### Script for automating creating incus containers ###

### VARS ###
#IMAGE="debian/12"
#PROFILE="incusbr-profile"
#CONTAINER_NAME="djole-djoledjole"
#INTERFACE_NAME="incusbr0"
CONTAINER_NAME="$1"
IMAGE="$2"
PROFILE="$3"
INTERFACE_NAME="$4"
NETWORK_FILE="/etc/systemd/network/'$INTERFACE_NAME'.network"

### Function for handling errors ###
handle_error() {
  echo -e "Error: $1"
  exit 1
}

if [ $# -lt 4 ]; then
  echo -e "\n---> Usage: $0 <container_name> <image> <profile> <interface_name> <---"
  echo -e "\n---> Example: $0 djole debian/12 eth0 <---"
  exit 1
fi

incus launch images:"$IMAGE" "$CONTAINER_NAME" -p "$PROFILE" || handle_error "\n---> Container not created... Exiting... <---"
sleep 10
echo -e "\n---> Incus container '$CONTAINER_NAME' created. <---"

incus exec "$CONTAINER_NAME" -- /bin/bash <<EOF
tee "$NETWORK_FILE" > /dev/null <<EONET
[Match]
Name=$INTERFACE_NAME
[Network]
DHCP=yes
EONET
networkctl reload
sleep 10
echo -e "\n---> Interface status: <---"
networkctl | grep "$INTERFACE_NAME"
EOF

echo -e "\n---> Container IP: $(incus ls | grep  "$CONTAINER_NAME"| awk '{ print $6 }') <--- "#!/bin/bash
### Script for automating creating incus containers ###