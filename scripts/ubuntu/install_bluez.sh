#!/bin/bash
[ "true" == "${IGNORE_REPO_UPDATE}" ] || apt-get udpate

# Install all necessary packages for building BlueZ
apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev build-essential git socat libbluetooth-dev

# Build BlueZ and install.
cd /opt
git clone https://github.com/yagamy4680/bluepy.git
cd bluepy
BLUEZ_INSTALLATION=true ./build.sh


# With py-gobject and dbus modules, the bluez python sample
# codes can work normally.
#
if [ "true" == "${INSTALL_PYTHON_PACKAGES}" ]; then
	apt-get install -y python-pip python-dev python-gobject python-dbus
	pip install pyserial rainbow_logging_handler
fi


if [ "true" == "${INSTALL_NODEJS_PACKAGES}" ]; then
# Sometimes, install noble/bleno/sensortag on VirtualBox might hang. Let's install
# these packages manually
#
#	npm install -g noble
#	npm install -g bleno
#	npm install -g sensortag
fi
