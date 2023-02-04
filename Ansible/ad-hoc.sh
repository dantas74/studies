#!/bin/bash

## Check connection with all hosts
ansible all -m ping

## Run commands in different groups
ansible aws -m shell -a "free -m"
ansible gcp -m shell -a "uptime"

## Copies file to hosts
ansible all -m copy -a "src=ad-hoc.sh dest=/tmp"

## Pastes content in destination on remote host
ansible all -m copy -a "content='Hello, World!' dest=/tmp/hello-world.txt"

## Create a file with specific permissions
ansible all -m file -a "path=/tmp/aloha.txt mode=0775 state=touch"

## Delete a file
ansible all -m file -a "path=/tmp/aloha.txt state=absent"

## Create a directory
ansible all -m file -a "path/tmp/alohas state=directory"

## Install packages in host
ansible aws -m apt -a "name=nginx state=present" -b
ansible gcp -m yum -a "name=nginx state=present" -b

## List all configuration of the host machine (Ansible Facts)
ansible all -m setup

## Filter configurations
ansible all -m setup -a "filter=ansible_memory_mb"

## Setup custom facts in hosts
ansible all -m file -a "path=/etc/ansible/facts.d mode=0755 state=directory"
ansible all -m copy -a "src=facts.d/sample.fact mode=0755 dest=/etc/ansible/facts.d" -b
