#!/bin/bash

## Install plugins and lock state
terraform init

## Plan what will be done in terraform apply
terraform plan

## Apply the changes proposed by the config files
terraform apply

sleep 5

## Destroy configuration stored in state files
terraform destroy
