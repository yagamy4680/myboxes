#!/bin/bash

# Update APT repositories
apt-get update

# Install all necessary packages for Arduino development
#
apt-get install -y arduino python-pip picocom build-essential vim

# Install command-line tools for Arduino build system
#
pip install ino

# Install all necessary packages for BlueZ development
#
apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev
apt-get install -y python-gobject python-dbus
