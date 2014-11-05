#!/bin/bash
[ "true" == "${IGNORE_REPO_UPDATE}" ] || apt-get udpate

LINUX_VERSION=$(uname -r | cut -d'-' -f1)

MARK="/opt/usbip.installation.mark"

if [ -f "${MARK}" ]; then
	echo "usbip kernel module is installed"
fi

apt-get install -y autoconf build-essential libtool libsysfs-dev
apt-get install -y linux-source
cd /tmp
tar -xjf /usr/src/linux-source-${LINUX_VERSION}.tar.bz2
cd linux-source-${LINUX_VERSION}/drivers/staging/usbip/userspace/
./autogen.sh
./configure --prefix=/usr --sysconfdir=/etc
make
make install

AUTO_MODULE="/etc/modules"

modprobe -a usbip-core usbip-host vhci-hcd
sed -i 's/^usbip-core//g' ${AUTO_MODULE}
sed -i 's/^usbip-host//g' ${AUTO_MODULE}
sed -i 's/^vhci-hcd//g' ${AUTO_MODULE}
echo usbip-core >> ${AUTO_MODULE}
echo usbip-host >> ${AUTO_MODULE}
echo vhci-hcd >> ${AUTO_MODULE}

echo "please type 'usbipd -D' to launch the USB/IP daemon ..."

