#!/bin/bash

DATE=$(date +%Y-%m-%d-%s)
DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
AMAZON_SECRET=$4
BACKUP_NAME=db-$DATE.sql

mysqldump -u root -h "$DB_HOST" "-p$DB_PASSWORD" "$DB_NAME" > "/tmp/$BACKUP_NAME"

export AWS_ACCESS_KEY_ID=1234
export AWS_SECRET_ACCESS_KEY=$AMAZON_SECRET

aws s3 cp "/tmp/$BACKUP_NAME" "s3://matheus-dr-mysql-backup/$BACKUP_NAME"
