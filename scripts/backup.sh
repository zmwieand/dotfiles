#!/bin/bash

NAS_SERVER=$(cat ~/.backuprc | grep "^  server: " | awk '{print $2}')
NAS_USER=$(cat ~/.backuprc | grep "^  user: " | awk '{print $2}')
MOUNT_LOCATION=$(cat ~/.backuprc | grep "^  mountLocation: " | awk '{print $2}' | gsed "s@\~@${HOME}@g")

# Mount the NAS
mount_smbfs "//${NAS_SERVER}/${NAS_USER}" ${MOUNT_LOCATION}

# If there is an error mounting fail fast
if [[ $? -ne 0 ]]; then
  echo "There was an error mounting ... to ..."
  exit 1
fi

# Perfrom Backup
cd ~/dev/dotfiles/backup
pipenv run python -m src.main

# Unmount the NAS
umount ${MOUNT_LOCATION}
