#!/bin/bash

NETWORK_NAME=" Your Moms House"
SERVER_IP="192.168.1.218"

DISK_MOUNTED=$(/sbin/mount | grep "${SERVER_IP}")
NETWORK_ACTIVE=$(/sbin/ifconfig en0 | grep "status: active")

# If already mounted, ignore
if [[ ! -z ${DISK_MOUNTED} ]]; then
  # If the network is inactive, unmount the drive
  if [[ -z ${NETWORK_ACTIVE} ]]; then
    /sbin/umount ~/NAS
  fi

  exit 0
fi

# Make sure the network is active and we are connected to the home network
if [[ ! -z ${NETWORK_ACTIVE} ]]; then
  echo "Network is active"
  SSID=$(/usr/sbin/networksetup -getairportnetwork en0 | cut -d: -f2)
  if [[ ${SSID} =~ ^${NETWORK_NAME} ]]; then
    echo "Connected to home network"
    /sbin/mount_smbfs //$(cat ~/.smb_credentials)@${SERVER_IP}/Share ~/NAS
    EXIT_CODE=$?

    if [[ ${EXIT_CODE} != 0 ]]; then
      /usr/bin/osascript -e 'display notification "Error: Failed to mount drive" with title "Network Attached Storage"' && sleep 10
    fi
  fi
fi
