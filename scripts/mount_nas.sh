#!/bin/bash

NETWORK_NAME="Wieand_Network"

DISK_MOUNTED=$(/sbin/mount | grep "192.168.1.1")
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
  SSID=$(/usr/sbin/networksetup -getairportnetwork en0 | cut -d: -f2 | cut -d ' ' -f2)
  if [[ ${SSID} =~ ^${NETWORK_NAME} ]]; then
    /sbin/mount_smbfs //192.168.1.1/Zach ~/NAS
    EXIT_CODE=$?

    if [[ ${EXIT_CODE} != 0 ]]; then
      /usr/bin/osascript -e 'display notification "Error: Failed to mount drive" with title "Network Attached Storage"' && sleep 10
    fi
  fi
fi
