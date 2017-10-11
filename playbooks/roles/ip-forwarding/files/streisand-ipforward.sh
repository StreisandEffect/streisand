#!/bin/sh
### BEGIN INIT INFO
# Provides:          streisand-ipforward
# Required-Start:    $network $remote_fs $local_fs
# Required-Stop:     $network $remote_fs $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Persist IP forwarding settings for Streisand
### END INIT INFO

echo 1 > /proc/sys/net/ipv4/ip_forward

echo 0 | tee /proc/sys/net/ipv4/conf/*/*_redirects

exit 0
