#!/bin/bash

## Build the application image
docker build -t feedback-app .

## Remind that anonymous volumes can also be created inside Dockerfile
docker run -d --rm -p 3000:80 --name feedback-app \
  -v feedbacks:/usr/app/feedback -v "$PWD:/usr/app:ro" \
  -v /usr/app/temp -v /usr/app/node_modules \
  --build-arg DEFAULT_PORT=90 feedback-app

## Create volume
docker volume create volume-name

## Inspect volume
docker volume inspect volume-name

## Remove volume
docker volume rm volume-name

## List volumes
docker volume ls
