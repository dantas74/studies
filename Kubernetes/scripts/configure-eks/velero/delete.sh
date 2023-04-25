#!/bin/bash

## Variables definition
AWS_PROFILE=$1
BUCKET_NAME=$2
PATH_TO_ACCESS_ID=$3
AUTO=$4

if [ -z "$AWS_PROFILE" ] || [ -z "$BUCKET_NAME" ] || [ -z "$PATH_TO_ACCESS_ID" ]; then
    echo "Missing required argument"
    exit 1
fi

AWS_REGION=$(aws configure get region --profile "$AWS_PROFILE")
ACCESS_KEY_ID=$(grep -oP '(?<=aws_access_key_id=)[^"].*' "$PATH_TO_ACCESS_ID")

## Deletes Velero user
aws iam delete-access-key --profile "$AWS_PROFILE" --user-name velero --access-key-id "$ACCESS_KEY_ID"
aws iam delete-user-policy --profile "$AWS_PROFILE"  --user-name velero --policy-name velero
aws iam delete-user --profile "$AWS_PROFILE"  --user-name velero

if [ "$AUTO" == "1" ]; then
    aws s3 rm "s3://$BUCKET_NAME" --profile "$AWS_PROFILE" --region "$AWS_REGION" --recursive
    aws s3api delete-bucket --profile "$AWS_PROFILE" --region "$AWS_REGION" --bucket "$BUCKET_NAME"
else
    ## Prompts to delete S3 backups bucket or no
    declare INPUT
    echo "Do you want to delete the backups bucket? (only 'yes' is accepted for deletion)"
    read -r INPUT
fi

if [ "$INPUT" == "yes" ]; then
    echo "OBSERVATION: All stored backups will be deleted, make sure you don't have problems with it ('confirm' to delete bucket)"
    read -r INPUT
    if [ "$INPUT" == "confirm" ]; then
        aws s3 rm "s3://$BUCKET_NAME" --profile "$AWS_PROFILE" --region "$AWS_REGION" --recursive
        aws s3api delete-bucket --profile "$AWS_PROFILE" --region "$AWS_REGION" --bucket "$BUCKET_NAME"
    fi
fi
