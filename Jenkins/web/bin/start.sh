#!/bin/bash

/usr/sbin/sshd

/usr/sbin/php-fom -c /etc/php/fpm

nginx -g 'daemon off;'
