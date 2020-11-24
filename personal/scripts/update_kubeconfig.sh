#!/bin/bash

function usage()
{
  echo "USAGE: ./update_kubeconfig.sh <aws cluster name>"
  exit 1
}

if [[ $# != 1 ]]; then
  usage
fi

CLUSTER_NAME=$1

rm ~/.kube/config
aws eks update-kubeconfig --name ${CLUSTER_NAME}

chmod 600 ~/.kube/config
