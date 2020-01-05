# Source of packages installed

## From APT

- Ubuntu standard repositories
  - [Streisand Common Packages](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/common/vars/main.yml)
  - [`bind`](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/dnsmasq/tasks/main.yml)
  - [`dnsmasq`](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/dnsmasq/tasks/main.yml)
  - [Libreswan Compilation Dependencies](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/l2tp-ipsec/vars/main.yml)
  - [OpenConnect Dependencies](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/openconnect/vars/main.yml)
  - [Shadowsocks Dependencies](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/vars/main.yml)
  - [`sslh`](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/sslh/tasks/main.yml)
  - [`stunnel4`](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/stunnel/tasks/main.yml)
  - [`tinyproxy`](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/tinyproxy/tasks/main.yml)
  - [`ufw`](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/ufw/tasks/main.yml)
- from 3rd party repositories:
  - [`nginx` (from nginx.org)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/nginx/tasks/main.yml)
  - [`obbfs4proxy` (from deb.torproject.org)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/tor-bridge/tasks/main.yml)
  - [Wireguard Packages (from wireguard PPA)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/wireguard/tasks/install.yml)
  - [Acmetool (from PPA)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/lets-encrypt/tasks/install.yml)

## Source
- [Libreswan](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/l2tp-ipsec/vars/main.yml)
- [OpenConnect](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/openconnect/vars/main.yml)
- [OpenVPN (from build.openvpn.net)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/openvpn/vars/mirror.yml)
- [Shadowsocks (from github.com/shadowsocks)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/tasks/main.yml)
- [Shadowsocks Simple-obfs (from github.com/shadowsocks-simpleobfs)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/tasks/simple-obfs.yml)


# Source of all clients mirrored

- Android
  - [Shadowsocks (from github.com/shadowsocks)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/vars/mirror.yml)
- Linux
  - [Shadowsocks (from github.com/shadowsocks)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/vars/mirror.yml)
  - [Tor Browser (from dist.torproject.org)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/tor-bridge/vars/mirror-common.yml)
- macOS
  - [Tunnelblick (from tunnelblick.net)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/openvpn/vars/mirror.yml)
  - [Shadowsocks (from github.com/shadowsocks)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/vars/mirror.yml)
  - [Tor Browser (from dist.torproject.org)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/tor-bridge/vars/mirror-common.yml)
- Windows
  - [OpenVPN (from build.openvpn.net)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/openvpn/vars/mirror.yml)
  - [Shadowsocks (from github.com/shadowsocks)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/shadowsocks/vars/mirror.yml)
  - [Shuttle (from github.com/sshuttle)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/streisand-mirror/vars/ssh.yml)
  - [Stunnel (from stunnel.org)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/stunnel/vars/mirror.yml)
  - [Putty (from the.earth.li)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/streisand-mirror/vars/ssh.yml)
  - [Tor Browser (from dist.torproject.org)](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/tor-bridge/vars/mirror-common.yml)
