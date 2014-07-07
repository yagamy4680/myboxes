#!/bin/bash

# Update APT repositories
apt-get update

# Install all necessary packages for Arduino development
#
apt-get install -y arduino python-pip picocom build-essential vim

# Install command-line tools for Arduino build system
#
pip install ino
