#!/bin/bash
[ "true" == "${IGNORE_REPO_UPDATE}" ] || apt-get udpate

# Install all necessary packages for Arduino development
apt-get install -y arduino python-pip build-essential vim

# Install command-line tools for Arduino build system
#
pip install ino
