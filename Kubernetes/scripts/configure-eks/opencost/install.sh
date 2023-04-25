#!/bin/bash

## Install Prometheus (Pre req for opencost)
helm install my-prometheus --repo https://prometheus-community.github.io/helm-charts prometheus \
  --namespace prometheus --create-namespace \
  --set pushgateway.enabled=false \
  --set alertmanager.enabled=false \
  -f "$(dirname -- "$0")/prometheus-config/config.yml"

## Install opencost
kubectl apply --namespace opencost \
    -f "$(dirname -- "$0")/opencost"
