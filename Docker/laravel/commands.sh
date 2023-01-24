#!/bin/bash

## Start Laravel app
docker compose run --rm composer create-project --prefer-dist laravel/laravel .

## Start laravel setup
docker compose up -d --build web

## Make migrations
docker compose run --rm artisan migrate
