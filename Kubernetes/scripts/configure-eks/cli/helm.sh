#!/bin/bash

curl --silent --location https://get.helm.sh/helm-v3.11.2-linux-amd64.tar.gz | tar xz -C /tmp

sudo mv /tmp/linux-amd64/helm /usr/local/bin/
