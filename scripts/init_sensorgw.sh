#!/bin/bash

# Update APT repositories
apt-get update

# Install all necessary packages for Arduino development
#
apt-get install -y \
	python-pip build-essential vim python-gobject python-dbus \
	libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

# Install python packages
#
pip install pyserial bottle

# Build BlueZ
cd /root
wget http://www.kernel.org/pub/linux/bluetooth/bluez-5.13.tar.gz
tar xzvf bluez-5.13.tar.gz
cd bluez-5.13
./configure --disable-systemd
make -j$(nproc)
make install

# Install bonjour
apt-get install -y avahi-daemon
service avahi-daemon restart

cd /tmp
nohup /usr/local/libexec/bluetooth/bluetoothd -d -n &
