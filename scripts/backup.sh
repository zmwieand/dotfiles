#!/bin/bash

NAS_SERVER=$(cat ~/.backuprc | grep "^  server: " | awk '{print $2}')
NAS_USER=$(cat ~/.backuprc | grep "^  user: " | awk '{print $2}')
MOUNT_PATH=$(cat ~/.backuprc | grep "^  mountLocation: " | awk '{print $2}')

# Unmounts the NAS and removes the /tmp/backup directory
function cleanup() {
  # Unmount the NAS
  echo "Unmounting ${MOUNT_PATH}..."
  /sbin/umount ${MOUNT_PATH}

  # Remove the /tmp/backup dir
  rm -r ${MOUNT_PATH}
}

# Disconnect from the VPN if necessary
# echo "Killing VPN Connection..."
# sudo pkill -x "openvpn"

# Make a temp directory to mount the NAS
mkdir ${MOUNT_PATH}

# Mount the NAS
echo "Mounting ${NAS_SERVER} to ${MOUNT_PATH}"
/sbin/mount_smbfs //${NAS_SERVER}/Backups ${MOUNT_PATH}
EXIT_CODE=$?

# If there is an error mounting fail fast
if [[ ${EXIT_CODE} -ne 0 ]]; then
  echo "[Error]: There was an error mounting ${NAS_SERVER} to ${MOUNT_PATH}"
  echo "Exit Code: ${EXIT_CODE}"
  cleanup
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

# Unmount the NAS and cleanup temp directory
cleanup
