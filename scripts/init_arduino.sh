#!/bin/bash

# Update APT repositories
apt-get update

# Install all necessary packages for Arduino development
#
apt-get install -y arduino python-pip picocom build-essential vim

# Install command-line tools for Arduino build system
#
pip install ino

# Install python serial package
#
pip install serial

# Install all necessary packages for BlueZ development
#
apt-get install -y python-gobject python-dbus

# Install all necessary packages for building BlueZ
apt-get install -y libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

# Build BlueZ
cd /tmp
wget http://www.kernel.org/pub/linux/bluetooth/bluez-5.13.tar.gz
tar xzvf bluez-5.13.tar.gz
cd bluez-5.13
./configure --disable-systemd
make -j$(nproc)
make install

# Install bonjour
apt-get install -y avahi-daemon
service avahi-daemon restart
