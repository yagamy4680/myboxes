#!/bin/bash
[ "true" == "${IGNORE_REPO_UPDATE}" ] || apt-get udpate

# Install all necessary packages for building BlueZ
apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev build-essential git

# Build BlueZ and install.
cd /opt
git clone https://github.com/yagamy4680/bluepy.git
cd bluepy
BLUEZ_INSTALLATION=true ./build.sh

# With py-gobject and dbus modules, the bluez python sample
# codes can work normally.
# 
if [ "true" == "${INSTALL_PYTHON_PACKAGES}" ]; then
	apt-get install -y python-pip
	# pip install python-gobject python-dbus pyserial
    pip install pygobject python-dbus pyserial
fi


#
if [ "true" == "${INSTALL_NODEJS_PACKAGES}" ]; then
	apt-get install libbluetooth-dev
	npm install -g noble
	npm install -g bleno
	npm install -g sensortag
fi
