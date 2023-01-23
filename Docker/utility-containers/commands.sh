#!/bin/bash

## Build utility image
docker build -t npm-util .

## Start a new node project
docker run -it --rm -v "$PWD:/app" npm-util init

## Install express
docker run -it --rm -v "$PWD:/app" npm-util install express --save

## Start a new project with compose
docker compose run --rm npm init
