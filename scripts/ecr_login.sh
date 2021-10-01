#!/bin/bash

# AWS CLI v1
# eval $(aws ecr get-login --no-include-email --region us-east-1)

# AWS CLI v2
PROFILES=$(cat ~/.aws/config | grep -E "\[.*\]" | sed -e "s/\[//g" | sed -e "s/\]//g" | sed -e "s/profile //g")

for profile_name in ${PROFILES}
do
  ACCOUNT_ID=$(cat ~/.aws/config | grep -A 6 -E "\[.*${profile_name}\]" | grep "sso_account_id" | awk '{print $3}')

  # If this is not the default profile, add the --profile arg
  PROFILE_ARG=""
  if [[ ${profile_name} != "default" ]]; then
    PROFILE_ARG="--profile ${profile_name}"
  fi

  # Login with the proper Profile and Account ID
  aws ecr get-login-password --region us-east-1 ${PROFILE_ARG} | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com
done
