#!/bin/bash

# Provisions an EC2 instance to host
# Microsoft Active Directory (Windows 2022).

# Uses the provision-aws-hardware scripts available here:
# https://github.com/janosj/utilities
# You must login first (e.g. using awsLogin.sh)

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root to update the /etc/hosts file."
   exit 1
fi

SCRIPT_LOC=<location of provisionEC2Instance.js file>
KEYFILE=<your aws pemfile>
SECURITY_GROUP=<your sg id>
SUBNET=<your subnet id>
TAG_NAME=<username>-windowsAD
TAG_OWNER=<yourfirst.yourlast>
ROOT_VOL_GB=30
INSTANCE_TYPE=t2.micro
IMAGE_ID=ami-07a53499a088e4a8c    # Windows 2022
HOSTNAME_ENTRY=windows-ad

export NODE_PATH=/usr/local/lib/node_modules

# Usage:
# provisionOpsMgrInstance keyName securityGroupID subnetID tagName tagOwner rootVolumeGB instanceType imageId etcHostname

node $SCRIPT_LOC/provisionEC2Instance.js $KEYFILE $SECURITY_GROUP $SUBNET $TAG_NAME $TAG_OWNER $ROOT_VOL_GB $INSTANCE_TYPE $IMAGE_ID $HOSTNAME_ENTRY

