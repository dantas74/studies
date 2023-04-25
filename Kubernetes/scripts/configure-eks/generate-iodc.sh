#!/bin/bash

AWS_PROFILE=$1
EKS_CLUSTER_NAME=$2

if [ -z "$AWS_PROFILE" ] || [ -z "$EKS_CLUSTER_NAME" ]; then
    echo "Missing required argument"
    exit 1
fi

eksctl utils associate-iam-oidc-provider --cluster "$EKS_CLUSTER_NAME" --profile "$AWS_PROFILE" --approve
