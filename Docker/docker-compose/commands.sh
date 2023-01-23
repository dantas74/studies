#!/bin/bash

## Docker Network
docker network create goals-network

## Mongo DB
docker run --name mongodb --rm -d --network goals-network -v mongo-data:/data/db \
 -e MONGO_INITDB_USERNAME=dantas -e MONGO_INITDB_PASSWORD=password mongo

## Node app
cd backend || exit 1

docker build -t node-app .

docker run --name goals-backend --rm -d --network goals-network -p 80:80 \
-v logs-data:/usr/app/logs -v "$PWD:/usr/app" -e MONGO_USERNAME=dantas \
-e MONGO_PASSWORD=password node-app

## React app
cd ../frontend || exit 1

docker build -t react-app .

docker run --name goals-frontend --rm -d -p 3000:3000 -it \
-v "$PWD/src:/usr/app/src" react-app
