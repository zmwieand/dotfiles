#!/bin/bash

NAS_SERVER=$(cat ~/.backuprc | grep "^  server: " | awk '{print $2}')
NAS_USER=$(cat ~/.backuprc | grep "^  user: " | awk '{print $2}')
MOUNT_PATH=$(cat ~/.backuprc | grep "^  mountLocation: " | awk '{print $2}')

# Disconnect from the VPN if necessary
# echo "Killing VPN Connection..."
# sudo pkill -x "openvpn"

# Check if the NAS is mounted
NAS_MOUNTED=$(/sbin/mount | grep "${NAS_SERVER}")
if [[ -z ${NAS_MOUNTED} ]]; then
  echo "NAS Drive not mounted. Exiting..."
  exit 1
fi

# Perfrom Backup
DATE=$(date +"%m/%d/%Y")
TIME=$(date +"%H:%M:%S")
echo "Running Backup for ${DATE} at ${TIME}..."
cd ${HOME}/dev/dotfiles/backup
/usr/local/bin/pipenv run python -m src.main 2>&1 &

# Make sure the machine does not sleep for the duration of the backup
BACKUP_PID=$!
caffeinate -w ${BACKUP_PID}

DATE=$(date +"%m/%d/%Y")
TIME=$(date +"%H:%M:%S")
echo "Finished Backup for ${DATE} at ${TIME}..."
