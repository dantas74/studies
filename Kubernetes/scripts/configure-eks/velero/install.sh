#!/bin/bash

## Variables definition
AWS_PROFILE=$1
BUCKET_NAME=$2
SAFE_LOCATION_PATH=$3

if [ -z "$AWS_PROFILE" ] || [ -z "$BUCKET_NAME" ] || [ -z "$SAFE_LOCATION_PATH" ]; then
    echo "Missing required argument"
    exit 1
fi

AWS_REGION=$(aws configure get region --profile "$AWS_PROFILE")

## Creates bucket for saving velero backups
aws s3api create-bucket \
    --profile "$AWS_PROFILE" \
    --bucket "$BUCKET_NAME" \
    --region "$AWS_REGION" \
    --create-bucket-configuration "LocationConstraint=$AWS_REGION"

## Creates IAM user for Velero and set permissions
aws iam create-user --profile "$AWS_PROFILE" --user-name velero

cat > velero-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeVolumes",
                "ec2:DescribeSnapshots",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:AbortMultipartUpload",
                "s3:ListMultipartUploadParts"
            ],
            "Resource": [
                "arn:aws:s3:::$BUCKET_NAME/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::$BUCKET_NAME"
            ]
        }
    ]
}
EOF

## Attach permissions to created user
aws iam put-user-policy \
  --profile "$AWS_PROFILE" \
  --user-name velero \
  --policy-name velero \
  --policy-document file://velero-policy.json

## Creates programmatic access to Velero user
aws iam create-access-key --profile "$AWS_PROFILE" --user-name velero > velero-credentials-creation-response

ACCESS_KEY_ID=$(grep -oP '(?<="AccessKeyId": ")[^"].*(?<=",)' velero-credentials-creation-response | sed 's/",//g')
SECRET_ACCESS_KEY=$(grep -oP '(?<="SecretAccessKey": ")[^"].*(?<=",)' velero-credentials-creation-response | sed 's/",//g')

cat > velero-credentials <<EOF
[default]
aws_access_key_id=$ACCESS_KEY_ID
aws_secret_access_key=$SECRET_ACCESS_KEY
EOF

## Install Velero S3 plugin in K8s Cluster
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.6.0 \
    --bucket "$BUCKET_NAME" \
    --backup-location-config "region=$AWS_REGION" \
    --snapshot-location-config "region=$AWS_REGION" \
    --secret-file ./velero-credentials

## Copies velero credentials to a safe location, so you can access to the access of this user
cp ./velero-credentials "$SAFE_LOCATION_PATH"/velero-credentials

## Removes generated credentials and assets
rm -rf ./velero-credentials* ./velero-policy.json
