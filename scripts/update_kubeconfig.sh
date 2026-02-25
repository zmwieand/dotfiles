#!/bin/bash

function usage()
{
  echo "USAGE: ./update_kubeconfig.sh <cluster name>"
  exit 1
}

if [[ $# != 1 ]]; then
  usage
fi

CLUSTER_NAME=$1
kubectl config use-context ${CLUSTER_NAME}
