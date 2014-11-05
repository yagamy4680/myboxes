#!/bin/bash

TMP=$(pwd)
CURRENT=$(dirname $0)
cd ${CURRENT}
CURRENT=$(pwd)
cd ${TMP}

INSTALL_PKGS=wireless,nodejs,bluez,arduino ${CURRENT}/install.sh
