#!/bin/sh

TMP=$(pwd)
CURRENT=$(dirname $0)
cd ${CURRENT}
CURRENT=$(pwd)
cd ${TMP}

INSTALL_PKGS=nodejs,bluez ${CURRENT}/install.sh