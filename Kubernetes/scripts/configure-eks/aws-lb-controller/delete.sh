#!/bin/bash

## Variables definition
AWS_PROFILE=$1

if [ -z "$AWS_PROFILE" ]; then
    echo "Missing required argument"
    exit 1
fi

POLICY_ARN=$(aws iam list-policies --query "Policies[?PolicyName=='AWSLoadBalancerControllerIAMPolicy'].Arn" --profile "$AWS_PROFILE" --output text)

## Deletes generated role and policy
aws iam detach-role-policy --profile "$AWS_PROFILE" --role-name AmazonEKSLoadBalancerControllerRole --policy-arn "$POLICY_ARN"
aws iam delete-role --profile "$AWS_PROFILE" --role-name AmazonEKSLoadBalancerControllerRole
aws iam delete-policy --profile "$AWS_PROFILE" --policy-arn "$POLICY_ARN"
