#!/bin/bash
[ "true" == "${IGNORE_REPO_UPDATE}" ] || apt-get udpate

# Refet to https://github.com/joyent/node/wiki/installing-node.js-via-package-manager
#
wget -O- -q https://deb.nodesource.com/setup | sudo bash -
apt-get install -y nodejs

# Install required modules
#
npm install -g LiveScript@1.2.0
npm install -g coffee-script
npm install -g pm2 --unsafe-perm
