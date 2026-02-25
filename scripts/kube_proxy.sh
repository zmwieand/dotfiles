#!/bin/bash

DASHBOARD=$(kubectl -n kube-system get secrets | grep dashboard-admin | awk '{print $1}')
TOKEN=$(kubectl -n kube-system describe secrets ${DASHBOARD} | grep "token:" | awk '{print $2}')

echo ${TOKEN}
echo

echo ${TOKEN} | pbcopy
echo "Copied token to clipboard"
echo

echo Updated Link: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:https/proxy/#!/login
# kubectl proxy
