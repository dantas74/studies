#!/bin/bash

## Create network
docker network create --driver brigde favorites-net

## Build the image
docker build -t favorites-node .

## Run app container
docker run --name favorites -d --rm -p 3000:3000 --network favorites-net favorites-node

## Run mongodb container
docker run --name mongodb -d --rm --network favorites-net mongo
