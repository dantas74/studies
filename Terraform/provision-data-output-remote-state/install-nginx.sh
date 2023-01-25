#!/bin/bash

until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

apt update
apt install -y nginx

systemctl start nginx
