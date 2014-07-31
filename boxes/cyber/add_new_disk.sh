#!/bin/bash
# --------------------------------------------------------------
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# --------------------------------------------------------------

set -e
set -x

if [ -f /etc/stratos_dev_env_disk_added_date ]
then
   echo "Stratos runtime already provisioned so exiting."
   exit 0
fi

DEVICE="/dev/sdb"
PART="${DEVICE}1"

sudo fdisk -u ${DEVICE} <<EOF
n
p
1


t
8e
w
EOF

VOLGROUP=$(vgs --all | grep -v "VFree" | awk '{print $1}')

pvcreate ${PART}
vgextend ${VOLGROUP} ${PART}
lvextend -L +30G /dev/${VOLGROUP}/root # TODO the size needs to be passed in as a argument
resize2fs /dev/${VOLGROUP}/root

date > /etc/stratos_dev_env_disk_added_date
