#!/bin/bash
[ "true" == "${IGNORE_REPO_UPDATE}" ] || apt-get udpate

# Refet to https://github.com/joyent/node/wiki/installing-node.js-via-package-manager
#
curl -sL https://deb.nodesource.com/setup | sudo bash -
apt-get install -y nodejs

# Install required modules
#
npm install -g LiveScript
npm install -g coffee-script
npm install -g pm2
