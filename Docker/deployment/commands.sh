#!/bin/bash

## Local setup

docker build -t node-app .

docker run -d --rm --name node-app -p 80:80 node-app

docker tag node-app matheus-dr/node-app

## Preparing to deploy
docker login

docker push matheus-dr/node-app

## Remote host
docker run -d --rm --name node-app -p 80:80 matheus-dr/node-app
