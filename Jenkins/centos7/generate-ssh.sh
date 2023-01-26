#!/bin/bash

ssh-keygen -t rsa -f remote-key.pem

mv remote-key.pem.pub remote-key.pub
