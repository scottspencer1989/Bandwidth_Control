#!/bin/bash
#
#
#   Author: Md. Sazzad Hissain Khan
#   Date:   8 July, 2017
#
#

NETWORK_SERVICE_NAME="wi-fi"

if [ "$#" -ne 1 ]; then
    echo "Argument missing [on/off]"
    exit 0
fi

if [ $1 == "on" ]; then
    echo "Enabling secure proxy for $NETWORK_SERVICE_NAME"
    networksetup -setsecurewebproxystate "$NETWORK_SERVICE_NAME" on
    networksetup -setwebproxystate "$NETWORK_SERVICE_NAME" on
elif [ $1 == "off" ]; then
    echo "Disabling secure proxy for $NETWORK_SERVICE_NAME"
    networksetup -setsecurewebproxystate "$NETWORK_SERVICE_NAME" off
    networksetup -setwebproxystate "$NETWORK_SERVICE_NAME" off
else
    echo "Argument invalid [permitted:on/off]"
fi