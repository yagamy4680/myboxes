#!/bin/bash

# Update APT repositories
apt-get update

# Install all necessary packages
#
apt-get install -y python-pip python-dev python-gobject python-dbus build-essential vim git

# Install necessary python packages
#
pip install pyserial twisted rainbow_logging_handler
