#!/bin/bash

sudo apt udpate
sudo apt upgrade -y
sudo apt install -y default-jre

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
echo "deb https://artifacts.elastic.co/packages/oss-7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

sudo apt install -y elasticsearch logstash kibana metricbeat
sleep 10

sudo mv /tmp/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo mv /tmp/kibana.yml /etc/kibana/kibana.yml

sudo service elasticsearch start
sudo service kibana start
sudo service metricbeat start
sudo service logstash start

