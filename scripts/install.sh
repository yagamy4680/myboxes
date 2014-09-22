#!/bin/bash

# Detect the Linux distribution
#
OS="linux"
[ "" == "$(uname -a | grep -i ubuntu)" ] || OS="ubuntu"
[ "" == "$(uname -a | grep -i darwin)" ] || OS="darwin"
[ "" == "$(lsb_release -a | grep -i Distributor | grep -i ubuntu)" ] || OS="ubuntu"

# Github base url
#
[ "" == "${BASE_URL}" ] && BASE_URL="https://raw.githubusercontent.com/yagamy4680/myboxes/master/scripts/${OS}"

# Detect current directory
#
TMP=$(pwd)
CURRENT=$(dirname $0)
cd ${CURRENT}
CURRENT=$(pwd)
cd ${TMP}

# Fetch command
[ "true" == "${FROM_GITHUB}" ] && FETCH_CMD="wget -O- -q ${BASE_URL}" || FETCH_CMD="cat ${CURRENT}/${OS}"

# Make sure INSTALL_PKGS is not null
[ "" == "${INSTALL_PKGS}" ] && echo "no packages to install, please specify packages at variable INSTALL_PKGS" && exit 1
PKGS=(`echo ${INSTALL_PKGS} | tr ',' '\n'`)


# Installation on Ubuntu system
#
if [ "ubuntu" == "${OS}" ]; then
	echo "OS = ${OS}"
	echo "FETCH_CMD = ${FETCH_CMD}"
	# apt-get update
	export IGNORE_REPO_UPDATE=true
	export INSTALL_NODEJS_PACKAGES=true
	export INSTALL_PYTHON_PACKAGES=true
	for i in "${PKGS[@]}"
	do
		echo "${FETCH_CMD}/install_$i.sh | /bin/bash"
		${FETCH_CMD}/install_$i.sh | /bin/bash
	done
fi

if [ "linux" == "${OS}" ]; then
	echo "unspported OS: $(uname -a)"
	exit 1
fi

