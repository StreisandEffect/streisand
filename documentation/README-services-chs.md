<a name="提供的服务"></a>
提供的服务
-----------------
* L2TP/IPsec 使用 [Libreswan](https://libreswan.org/)/[xl2tpd](https://www.xelerance.com/software/xl2tpd/) 架设。
  * 随机生成、选择预分享密钥和密码；
  * Windows, macOS, Android 和 iOS 用户可以使用系统自带的 VPN 进行设置、连接，而不需要另外下载第三方的软件来实现。
* [Monit](https://mmonit.com/monit/)
  * 能够监视、处理运行状态，针对那些奔溃的进程或者没有响应的进程进行自动重启和维护。
* [OpenSSH](http://www.openssh.com/)
  * 支持 Windows 和 Android 的 SSH 隧道， 并且需要使用 PuTTY 将默认的密钥对导出成 .ppk 的格式；
  * [Tinyproxy](https://banu.com/tinyproxy/) 默认安装并绑定到主机，它作为一个 http(s) 代理提供给那些原生不支持 SOCKS 代理的软件通过 SSH 隧道访问网络，比如说 Android 上的鸟嘀咕。
  * 针对 [sshuttle](https://github.com/sshuttle/sshuttle) 的一个无特权转发用户和产生的 SSH 密钥对，同样也兼容 SOCKS；
* [OpenConnect](http://www.infradead.org/ocserv/index.html) / [Cisco AnyConnect](http://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * oepnConnect (ocserv) 是一个非常强劲、轻巧的 VPN 服务器，并且完全兼容思科的 AnyConnect 客户端；
  * 其中包涵了很多顶级的标准[协议](http://www.infradead.org/ocserv/technical.html)，比如：HTTP, TLS 和 DTLS， 当然还有很多被跨国公司广泛使用的且流行的技术；
   * 这就意味着 OpenConnect 非常易用且高速，而且经得住审查的考验，几乎从未被封锁。
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * 从自带的 .ovpn 配置文件生成一个简单的客户端配置文件；
  * 同时支持 TCP 和 UDP 连接；
  * 客户端的 DNS 解析由 [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) 负责，避免 DNS 泄露；
  * 启用 TLS 认证，有助于防止主动探测攻击。错误的 HMAC 流量并不会被轻易丢弃。
* [Shadowsocks](http://shadowsocks.org/en/index.html)
  * 安装的是高性能的 libev 版本，这个版本能够处理数以千计的并发连接；
  * Android 和 iOS 只需要扫描一个二维码就能完成自动配置。DNS 可以设置为 8.8.8.8，或者将配置一一复制粘贴到客户端上；
  * 采用 ChaCha20 和 Poly1305 对 [AEAD](https://shadowsocks.org/en/spec/AEAD-Ciphers.html) 进行加密，增强了安全性并提升了穿透性；
  * 使用 [simple-obfs](https://github.com/shadowsocks/simple-obfs) 插件提供流量混淆以便于从审查的网络中脱逃（尤其是QOS节流中）。
* [sslh](http://www.rutschle.net/tech/sslh.shtml)
  * sslh 是一个协议解复用器（这个我不了解，如果有更好的翻译请request），在一个高度限制的网络环境下（只能访问 http 端口的网络为例），它作为一种备选方案，仍然可以通过 OpenSSH 和 OpenVPN 进行连接，因为通过 sslh 让二者共享了 443 端口。
* [Stunnel](https://www.stunnel.org/index.html)
  * 监听并且将 OpenVPN 的流量进行封装，让 OpenVPN 的流量伪装成标注的 SSL 流量，从而可以让 OpenVPN 客户端成功通过隧道进行连接，躲避深度包检测。
  * 通过隧道连接的 OpenVPN 的配置文件和直接连接 OpenVPN 的配置文件是一起生成的，详细的说明也一同生成。
  * stunnel 证书和密钥是 PKCS #12 格式，SSL 隧道程序能够很好的兼容，尤其 [OpenVPN Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn) 版本也能够通过 [SSLDroid](https://play.google.com/store/apps/details?id=hu.blint.ssldroid) 传输。在中国的移动设备上使用 OpenVPN 成为可能*（据译者所知，大陆 OpenVPN 以前完全阵亡）*。
* [Tor](https://www.torproject.org/)
  * 桥接的名字是随即生成的；
  * [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) 默认安装并且配置支持 obfs4 传输；
  * Android 手机使用 [Orbot](https://play.google.com/store/apps/details?id=org.torproject.android) 扫描二维码即可获取桥接信息并完成自动配置。
* [UFW](https://wiki.ubuntu.com/UncomplicatedFirewall)
  * 防火墙根据不同的服务完全配置好，任何未经授权的流量都将被阻止。
* [系统无人值守安全更新](https://help.ubuntu.com/community/AutomaticSecurityUpdates)
  * Streisand 所在的服务器自动配置成无人值守更新，自动更新级别为*安全更新*。
* [WireGuard](https://www.wireguard.com/)
  * Linux 用户可以使用下一代更加简化，基于内核的黑科技 VPN ，速度快，而且使用了很多之前 VPN 所没有加密类型。
