# Services

Services Provided
-----------------

* [OpenSSH](https://www.openssh.com/)
  * Windows and Android SSH tunnels are also supported, and a copy of the keypair is exported in the `.ppk` format that PuTTY requires.
  * [Tinyproxy](https://banu.com/tinyproxy/) can be installed and bound to localhost. It can be accessed over an SSH tunnel by programs that do not natively support SOCKS and that require an HTTP proxy, such as Twitter for Android.
  * An unprivileged forwarding user and SSH keypair can be generated for [sshuttle](https://github.com/sshuttle/sshuttle) and SOCKS capabilities.
* [OpenConnect](https://ocserv.gitlab.io/www/index.html) / [Cisco AnyConnect](https://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * OpenConnect (ocserv) is an extremely high-performance and lightweight VPN server that also features full compatibility with the official Cisco AnyConnect clients.
  * The [protocol](https://ocserv.gitlab.io/www/technical.html) is built on top of standards like HTTP, TLS, and DTLS, and it's one of the most popular and widely used VPN technologies among large multi-national corporations.
    * This means that in addition to its ease-of-use and speed, OpenConnect is also highly resistant to censorship and is almost never blocked.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * When enabled, self-contained "unified" .ovpn profiles are generated for easy client configuration using only a single file.
  * Both TCP and UDP connections are supported.
  * Client DNS resolution is handled via [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) to prevent DNS leaks.
  * TLS Authentication is enabled which helps protect against active probing attacks. Traffic that does not have the proper HMAC is simply dropped.
* [Shadowsocks](https://shadowsocks.org/en/index.html)
  * When enabled, the high-performance [libev variant](https://github.com/shadowsocks/shadowsocks-libev) is installed. This version is capable of handling thousands of simultaneous connections.
  * A QR code is generated that can be used to automatically configure the Android and iOS clients by simply taking a picture. You can tag '8.8.8.8' on that concrete wall, or you can glue the Shadowsocks instructions and some QR codes to it instead!
  * [AEAD](https://shadowsocks.org/en/spec/AEAD-Ciphers.html) support is enabled using ChaCha20 and Poly1305 for enhanced security and improved GFW evasion.
  * The [simple-obfs](https://github.com/shadowsocks/simple-obfs) plugin is installed to provide robust traffic evasion on hostile networks (especially those implementing quality of service (QOS) throttling).
* [sslh](https://www.rutschle.net/tech/sslh/README.html)
  * Sslh is a protocol demultiplexer that allows Nginx, OpenSSH, and OpenVPN to share port 443. This provides an alternative connection option and means that you can still route traffic via OpenSSH and OpenVPN even if you are on a restrictive network that blocks all access to non-HTTP ports.
* [Stunnel](https://www.stunnel.org/index.html)
  * When enabled, listens for and wraps OpenVPN connections. This makes them look like standard SSL traffic and allows OpenVPN clients to successfully establish tunnels even in the presence of Deep Packet Inspection.
  * Unified profiles for stunnel-wrapped OpenVPN connections are generated alongside the direct connection profiles. Detailed instructions are also generated.
  * The stunnel certificate and key are exported in PKCS #12 format so they are compatible with other SSL tunneling applications. Notably, this enables [OpenVPN for Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn) to tunnel its traffic through [SSLDroid](https://play.google.com/store/apps/details?id=hu.blint.ssldroid). OpenVPN in China on a mobile device? Yes!
* [Tor](https://www.torproject.org/)
  * If chosen by the user a [bridge relay](https://www.torproject.org/docs/bridges) is set up with a random nickname.
  * [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) is installed and configured with support for the obfs4 pluggable transport.
  * A BridgeQR code is generated that can be used to automatically configure [Orbot](https://play.google.com/store/apps/details?id=org.torproject.android) for Android.
* [UFW](https://wiki.ubuntu.com/UncomplicatedFirewall)
  * Firewall rules are configured for every service, and any traffic that is sent to an unauthorized port will be blocked.
* [unattended-upgrades](https://help.ubuntu.com/community/AutomaticSecurityUpdates)
  * Your Streisand server is configured to automatically install new security updates.
* [WireGuard](https://www.wireguard.com/)
  * Linux users can take advantage of this next-gen, simple, kernel-based, state-of-the-art VPN that also happens to be ridiculously fast and uses modern cryptographic principles that all other highspeed VPN solutions lack.
