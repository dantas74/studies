#!/bin/bash

## Start a deployment and exposes it via a LoadBalancer ##
docker build -t matheusdr/kub-first-app:latest .
docker push matheusdr/kub-first-app

kubectl create deployment first-app --image=matheusdr/kub-first-app

kubectl expose deployment first-app --port=8080 --type=LoadBalancer

minikube service first-app

kubectl scale deployment/first-app --replicas=3

## Process of updating and reverting a deployment ##
docker build -t matheusdr/kub-first-app:v2 . # it needs to have a different tag
docker push matheusdr/kub-first-app

kubectl set image deployment/first-app

kubectl rollout status deployment/first-app

kubectl rollout undo deployment/first-app
kubectl rollout undo deployment/first-app --to-revision=1

kubectl rollout history deployment/first-app
kubectl rollout history deployment/first-app --revision=1

## Declarative approach ##
kubectl apply -f=deployment.yml -f=service.yml
kubectl delete -f=deployment.yml -f=service.yml

kubectl delete deployments,services -l group=example
