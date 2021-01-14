#!/bin/bash

NAS_SERVER=$(cat ~/.backuprc | grep "^  server: " | awk '{print $2}')
NAS_USER=$(cat ~/.backuprc | grep "^  user: " | awk '{print $2}')
MOUNT_LOCATION=$(cat ~/.backuprc | grep "^  mountLocation: " | awk '{print $2}' | /usr/local/bin/gsed "s@\~@${HOME}@g")

# Disconnect from the VPN if necessary
echo "Killing VPN Connection..."
sudo pkill -x "openvpn"

# Mount the NAS
echo "Mounting ${NAS_SERVER} to ${MOUNT_LOCATION}"
/sbin/mount_smbfs //${NAS_SERVER}/${NAS_USER} ${MOUNT_LOCATION}
EXIT_CODE=$?

# If there is an error mounting fail fast
if [[ ${EXIT_CODE} -ne 0 ]]; then
  echo "[Error]: There was an error mounting ${NAS_SERVER} to ${MOUNT_LOCATION}"
  echo "Exit Code: ${EXIT_CODE}"
  exit 1
fi

# Perfrom Backup
echo "Running Backup..."
cd ${HOME}/dev/dotfiles/backup
echo "CWD: `pwd`"
/usr/local/bin/pipenv run python -m src.main 2>&1 >> /tmp/cron.log &

# Make sure the machine does not sleep for the duration of the backup
BACKUP_PID=$!
echo "PID: ${BACKUP_PID}"
caffeinate -w ${BACKUP_PID}
echo "Finished Backup..."

# Unmount the NAS
echo "Unmounting ${MOUNT_LOCATION}..."
/sbin/umount ${MOUNT_LOCATION}
