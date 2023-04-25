#!/bin/bash

## Variables definitions
AWS_PROFILE=$1
EKS_CLUSTER_NAME=$2

if [ -z "$AWS_PROFILE" ] || [ -z "$EKS_CLUSTER_NAME" ]; then
    echo "Missing required argument"
    exit 1
fi

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --profile "$AWS_PROFILE" --output text)
AWS_REGION=$(aws configure get region --profile "$AWS_PROFILE")

## Retrieves IAM policy for load balancer controller and creates it
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.7/docs/install/iam_policy.json
aws iam create-policy \
    --profile "$AWS_PROFILE" \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

## Gets OIDC
OIDC_ID=$(aws eks describe-cluster --name "$EKS_CLUSTER_NAME" --query "cluster.identity.oidc.issuer" --output text --profile "$AWS_PROFILE" | cut -d '/' -f 5)

## Creates role and its permissions
cat >load-balancer-role-trust-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::$AWS_ACCOUNT_ID:oidc-provider/oidc.eks.$AWS_REGION.amazonaws.com/id/$OIDC_ID"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.$AWS_REGION.amazonaws.com/id/$OIDC_ID:aud": "sts.amazonaws.com",
                    "oidc.eks.$AWS_REGION.amazonaws.com/id/$OIDC_ID:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
                }
            }
        }
    ]
}
EOF

aws iam create-role \
  --profile "$AWS_PROFILE" \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --assume-role-policy-document file://"load-balancer-role-trust-policy.json"

aws iam attach-role-policy \
  --profile "$AWS_PROFILE" \
  --policy-arn "arn:aws:iam::$AWS_ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy" \
  --role-name AmazonEKSLoadBalancerControllerRole

## Creates and applies service account for controller in EKS cluster
cat >aws-load-balancer-controller-service-account.yaml <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/name: aws-load-balancer-controller
  name: aws-load-balancer-controller
  namespace: kube-system
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::$AWS_ACCOUNT_ID:role/AmazonEKSLoadBalancerControllerRole
EOF

kubectl apply -f aws-load-balancer-controller-service-account.yaml

## Applies certificate manager for EKS cluster
kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml

## Configures controller
helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set "clusterName=$EKS_CLUSTER_NAME" \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller

kubectl get deployment -n kube-system aws-load-balancer-controller

rm -rf ./*.{yaml,json,yaml.bak}
