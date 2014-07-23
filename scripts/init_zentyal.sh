#!/bin/bash

CHECK_FILE="/etc/stratos_zentyal_installed_date"
if [ -f "${CHECK_FILE}" ]; then
	echo "Already install Zentyal"
	exit 0
fi

echo "deb http://archive.zentyal.org/zentyal 3.4 main extra" >> /etc/apt/sources.list
date >> ${CHECK_FILE}

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 10E239FF
wget -q http://keys.zentyal.org/zentyal-3.4-archive.asc -O- | sudo apt-key add -
apt-get update

cat <<EOF
Please type following command to install Zentyal, and then visit https://<ip/ to 
manually install necessary components for Zentyal. (Note, during Zentyal installtion,
there are some questions to be filled manually):

apt-get install zentyal -y
EOF
