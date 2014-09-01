#!/bin/bash

echo "udpate apt repository"
apt-get update -q

echo "install required system packages"
apt-get install -y vim virt-what

echo "install docker"
curl -s https://get.docker.io/ubuntu/ | sudo sh
