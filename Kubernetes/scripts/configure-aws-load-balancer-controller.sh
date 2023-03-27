#!/bin/bash

AWS_PROFILE=$1
EKS_CLUSTER_NAME=$2

aws eks update-kubeconfig --profile "$AWS_PROFILE" --name "$EKS_CLUSTER_NAME"

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --profile "$AWS_PROFILE" --output text)
AWS_REGION=$(aws configure get region --profile "$AWS_PROFILE")

curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.7/docs/install/iam_policy.json

aws iam create-policy \
    --profile $AWS_PROFILE \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

OIDC_ID=$(aws eks describe-cluster --name "$EKS_CLUSTER_NAME" --query "cluster.identity.oidc.issuer" --output text --profile "$AWS_PROFILE" | cut -d '/' -f 5)

eksctl utils associate-iam-oidc-provider --cluster "$EKS_CLUSTER_NAME" --approve

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

kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.5.4/cert-manager.yaml

curl -Lo v2_4_7_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.7/v2_4_7_full.yaml

sed -i.bak -e '561,569d' ./v2_4_7_full.yaml

sed -i.bak -e "s|your-cluster-name|$EKS_CLUSTER_NAME|" ./v2_4_7_full.yaml

kubectl apply -f v2_4_7_full.yaml

curl -Lo v2_4_7_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.4.7/v2_4_7_ingclass.yaml

kubectl apply -f v2_4_7_ingclass.yaml

kubectl get deployment -n kube-system aws-load-balancer-controller

rm -rf ./*.{yaml,json,yaml.bak}
