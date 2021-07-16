#!/bin/bash

# Arg parse
ARGS=$@
APP=$(echo ${ARGS} | grep -Eo "\-\-install [^ ]+" | cut -d ' ' -f 2)
NAMESPACE=$(echo ${ARGS} | grep -Eo "\-\-namespace [^ ]+" | cut -d ' ' -f 2)

if [[ ${APP} == "" || ${NAMESPACE} == "" ]]; then
  echo "[ERROR] Usage: helmdiff upgrade --install <name> <chart> --namespace <namespace> [ARGS]"
  exit 1
fi

# Temporary output files
MANIFEST_FILE="/tmp/${NAMESPACE}-${APP}-manifest.yaml"
DRY_RUN_FILE="/tmp/${NAMESPACE}-${APP}-dry-run.yaml"

# Save the manifest (what is currently running on the cluster) to a file
helm get manifest --namespace ${NAMESPACE} ${APP} > ${MANIFEST_FILE}

# Dry run install based on the input args and save output to a file
helm ${ARGS} --dry-run > ${DRY_RUN_FILE}

# Compare the temporary output files using vim
vim -d ${MANIFEST_FILE} ${DRY_RUN_FILE}

# Cleanup
rm ${MANIFEST_FILE} ${DRY_RUN_FILE}
