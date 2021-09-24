#!/bin/bash

# AWS CLI v1
# eval $(aws ecr get-login --no-include-email --region us-east-1)

# AWS CLI v2
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 294290347293.dkr.ecr.us-east-1.amazonaws.com
