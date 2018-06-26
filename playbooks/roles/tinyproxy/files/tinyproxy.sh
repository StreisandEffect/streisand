#!/usr/bin/env bash
# tinyproxy startup script
# portions lifted from original inti.d script by Ed Boraas, 1999
# https://www.apt-browse.org/browse/ubuntu/xenial/universe/amd64/tinyproxy/1.8.3-3ubuntu1/file/etc/init.d/tinyproxy

# Set errexit option to exit immediately on any non-zero status return
set -e

CONFIG=$1

# assert pidfile directory and permissions
USER=$(grep    -i '^User[[:space:]]'    "$CONFIG" | awk '{print $2}')
GROUP=$(grep   -i '^Group[[:space:]]'   "$CONFIG" | awk '{print $2}')
PIDFILE=$(grep -i '^PidFile[[:space:]]' "$CONFIG" | awk '{print $2}' |\
    sed -e 's/"//g')
PIDDIR=`dirname "$PIDFILE"`
if [ -n "$PIDDIR" -a "$PIDDIR" != "/var/run" ]; then
    if [ ! -d "$PIDDIR" ]; then
        mkdir "$PIDDIR"
    fi
    if [ "$USER" ]; then
        chown "$USER" "$PIDDIR"
    fi
    if [ "$GROUP" ]; then
        chgrp "$GROUP" "$PIDDIR"
    fi
fi

/usr/sbin/tinyproxy -c $CONFIG
