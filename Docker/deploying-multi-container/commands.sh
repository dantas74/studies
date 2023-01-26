#!/bin/bash

docker build -t node-app ./backend
docker build -t react-app ./frontend

docker tag node-app matheus-dr/node-app
docker tag react-app matheus-dr/react-app

docker push matheus-dr/node-app
docker push matheus-dr/react-app
