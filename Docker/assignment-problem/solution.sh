#!/bin/bash

cd python-app/ || exit 1

docker build -t python-app:exercise .

docker run -it --name python-app python-app:exercise

cd ../node-app/ || exit 1

docker build -t node-app:exercise .

docker run --name node-app -p 3000:3000 -d node-app:exercise

docker restart node-app python-app

docker stop node-app python-app

docker container prune -f

docker run --rm -it --name python-app python-app:exercise
docker run --name node-app -p 3000:3000 -d node-app:exercise

docker stop node-app python-app

docker rmi python-app:exercise node-app:exercise
