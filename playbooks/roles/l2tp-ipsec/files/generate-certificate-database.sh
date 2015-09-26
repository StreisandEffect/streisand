#!/bin/bash
echo > /var/tmp/libreswan-nss-pwd
/usr/bin/certutil -N -f /var/tmp/libreswan-nss-pwd -d /etc/ipsec.d
/bin/rm -f /var/tmp/libreswan-nss-pwd
