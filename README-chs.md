<p align="center">
  <img src="https://raw.githubusercontent.com/jlund/streisand/master/logo.jpg" alt="Automate the effect"/> 
</p>

- - -
[English](README.md), [Français](README-fr.md), [简体中文](README-chs.md), [Русский](README-ru.md) | [Mirror](https://gitlab.com/alimakki/streisand)
- - -

[![Build Status](https://travis-ci.org/StreisandEffect/streisand.svg?branch=master)](https://travis-ci.org/StreisandEffect/streisand)
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/espadrine.svg?style=social&label=Follow%20%40StreisandVPN)](https://twitter.com/StreisandVPN)

Streisand
=========

**欲盖弥彰的[Streisand效应](https://zh.wikipedia.org/wiki/%E5%8F%B2%E7%BF%A0%E7%8F%8A%E6%95%88%E5%BA%94).**

互联网对我们并不公平。ISP、通信、政治家，他们串通一气封锁那些我们感兴趣和关注的网站和信息。或许是时候*打破枷锁*，来场正面较量了。

Streisand介绍
---------------------
* 只需要一个简单的脚本，就能在全新的 Ubuntu 16.04 服务器上运行[多个不同的科学上网工具](#提供的服务)，它们能够让你匿名并且加密所有的网络流量。
* Streisand 原生支持多个 VPS 供应商，其中包括[亚马逊EC2](https://aws.amazon.com/ec2/)，[微软云服务](https://azure.microsoft.com)，[DigitalOcean](https://www.digitalocean.com/)，[Google云计算](https://cloud.google.com/compute/)，[Linode](https://www.linode.com/)和[Rackspace](https://www.rackspace.com/)；随着软件的开发还将支持更多云和VPS——只要运行的是 Ubuntu 16.04 ，不论提供商是谁还是有**成百个**实例都能用这个方法部署。
* 整个部署过程顺利的话大概在10分钟左右搞定。试想一个没有系统管理能力的人可能要花数天来完成其中一项工作，而我们用 Streisand 让你获得获得开箱既得的畅快体验。
* 一旦部署完成，你可以将使用指南发送给你的朋友，家人和你觉得对你重要的人**（译者注：原文是社会活动家）**。在这个指南中包含唯一的一个 SSL 证书，这也意味着你发送给他们的只是一个简单的文件而已。
* 部署好网关中包含了用户需要的一切内容，例如设置向导，所支持操作系统需要的客户端。即使无法下载到官方客户端的朋友都可以在网关中的镜像里下载到需要的最新版本客户端。
* 这才是开始，来来来，看看后面更精彩...

更多特性
-------------
* 新用户登录时，使用 Nginx 提供密码保护和网关加密。加密网关通过 SSL 证书，或者通过 [Tor](https://www.torproject.org/docs/hidden-services.html.en)隐藏服务进行加密。
  * 网关将自动生成客户端配置说明，架设在轻量级的 http 服务器 Nginx 上。而您可以用电脑或是手机的浏览器轻松阅读，只需按部就班就能轻松配置客户端了。
  * 所有科学上网需要的客户端软件都进行了 SHA-256 检查，并且通过 GPG 进行了签名认证。确保那些无法通过官方渠道下载客户端的用户同样能够从镜像放心下载。
  * 所有客户端需要的额外文件，比如：OpenVPN 的配置文件，都可以通过网关下载到。
  * 目前 Tor 用户可以借助 Streisand 所提供的优秀特性传输大文件或者控制 Tor 服务其他流量（比如BT，传统的 Tor 并不适合进行BT这样的数据传输）。
  * 网关会自动生成一个唯一的密码、一个 SSL 证书和一个 SSL 私钥。在Streisand部署后，网关说明和证书都通过 SSH 进行传输。
  * 不同的服务和多个守护进程带来了巨大的灵活性。如果其中一个连接方式遭到封锁，还有其他方式可以尝试使用。它们大多数都能够避免深度包检测。
  * OpenConnect/AnyConnect, OpenSSH（没有测试）, OpenVPN (stunnel加持的), Shadowsocks, and Tor (obfs4进行混淆传输)都可以在中国使用
* 每一个科学上网工具都提供了文档和详细的描述。 Streisand 或许是迄今为止最为全面的指南，帮助你安装和配置客户端。在必要的时候也能够再次通过手动完成任何相关操作。
* 为了避免科学上网工具被大面积破坏，端口在设计上也是有讲究的。比方说 OpenVPN ，并没有运行在默认的1194端口，而是636端口，这个是很多跨国公司使用的标准 LDAP/SSL 连接端口。

<a name="提供的服务"></a>
提供的服务
-----------------

* [OpenSSH](https://www.openssh.com/)
  * 支持 Windows 和 Android 的 SSH 隧道， 并且需要使用 PuTTY 将默认的密钥对导出成 .ppk 的格式；
  * [Tinyproxy](https://banu.com/tinyproxy/) 默认安装并绑定到主机，它作为一个 http(s) 代理提供给那些原生不支持 SOCKS 代理的软件通过 SSH 隧道访问网络，比如说 Android 上的鸟嘀咕。
  * 针对 [sshuttle](https://github.com/sshuttle/sshuttle) 的一个无特权转发用户和产生的 SSH 密钥对，同样也兼容 SOCKS；
* [OpenConnect](https://ocserv.gitlab.io/www/index.html) / [Cisco AnyConnect](https://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * oepnConnect (ocserv) 是一个非常强劲、轻巧的 VPN 服务器，并且完全兼容思科的 AnyConnect 客户端；
  * 其中包涵了很多顶级的标准[协议](https://ocserv.gitlab.io/www/technical.html)，比如：HTTP, TLS 和 DTLS， 当然还有很多被跨国公司广泛使用的且流行的技术；
   * 这就意味着 OpenConnect 非常易用且高速，而且经得住审查的考验，几乎从未被封锁。
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * 从自带的 .ovpn 配置文件生成一个简单的客户端配置文件；
  * 同时支持 TCP 和 UDP 连接；
  * 客户端的 DNS 解析由 [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) 负责，避免 DNS 泄露；
  * 启用 TLS 认证，有助于防止主动探测攻击。错误的 HMAC 流量并不会被轻易丢弃。
* [Shadowsocks](https://shadowsocks.org/en/index.html)
  * 安装的是高性能的 libev 版本，这个版本能够处理数以千计的并发连接；
  * Android 和 iOS 只需要扫描一个二维码就能完成自动配置。DNS 可以设置为 8.8.8.8，或者将配置一一复制粘贴到客户端上；
  * 采用 ChaCha20 和 Poly1305 对 [AEAD](https://shadowsocks.org/en/spec/AEAD-Ciphers.html) 进行加密，增强了安全性并提升了穿透性；
  * 使用 [simple-obfs](https://github.com/shadowsocks/simple-obfs) 插件提供流量混淆以便于从审查的网络中脱逃（尤其是QOS节流中）。
* [sslh](https://www.rutschle.net/tech/sslh/README.html)
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

安装
------------
在你搞事情之前，认真阅读

### 重要说明 ###
Streisand 基于 [Ansible](https://www.ansible.com/) ，它可以在远程服务器完成自动配置、打包等工作，Streisand 是将远程服务器自动配置成为多个 VPN 服务及科学上网的工具。

Streisand 运行在**你自己的计算机上时（或者你电脑的虚拟机上时）**，它将把网关部署到你 VPS 提供商的**另一个服务器**上（通过你自己的API自动生成）。另外，如果 Streisand 运行在 VPS 上，它将会把网关部署到**另一个 VPS 上**，所以说原先你运行 Streisand 的那个 VPS 就多余了，记得部署完成并获得文档后把它删掉，而部署出来的那个 VPS 你是无法使用 SSH 连接进去的，除非你有公钥（当然这是不可能的，因为整个配置过程都没有提供公钥给你下载或者你想办法把它搞出来）。

在某些情况下，你可能需要运行 Streisand/Ansible 在 VPS 上并将其自身配置为 Streisand 服务器，这种模式适合当你无法在你自己的计算机上运行和安装 Streisand/Ansible 时，或本地与 VPS 之间的 SSH 连接不稳定时。

### 准备工作 ###
在本地计算机完成以下所有步骤（也可以在 VPS 上运行）。

* Streisand 运行在 BSD，Linux，或者 macOS 上，Windows 上是无法运行的。所有的指令都需要在终端下运行。
* 需要 Python 2.7 ，一般在 macOS 、Linux 及 BSD 系统上都是标配，如果你使用的发行版标配是 Python 3，你需要安装 Python 2.7 来运行 Streisand。
* 确定你的 SSH key 储存在 ~/.ssh/id\_rsa.pub 。
  * 如果不曾有过 SSH key，你需要用下面的命令生成一个：

        ssh-keygen
* 安装 Git 。
  * 基于 Debian 和 Ubuntu 的 Linux 发行版

        sudo apt install git
  * 在 Fedora

        sudo dnf install git
  * 在 macOS 上 （需要通过 [Homebrew](https://brew.sh/) 进行安装）

        brew install git
* 利用 Python 安装 [pip](https://pip.pypa.io/en/latest/) 包管理
  * 基于 Debian 和 Ubuntu 的 Linux 发行版

        sudo apt install python-paramiko python-pip python-pycurl python-dev build-essential
  * 在 Fedora

        sudo dnf install python-pip
  * 在 macOS 上

        sudo easy_install pip
        sudo pip install pycurl

* 安装 [Ansible](https://www.ansible.com/) 。
  * 在 macOS 上

        brew install ansible
  * 在 Linux 和 其他 BSD 上

        sudo pip install ansible markupsafe
* 以下使用 pip 安装的 Python 库根据你所使用的 VPS 供应商不同而不同。如果你准备将目前使用的 VPS 变成网关，可以跳过此步。
  * 亚马逊 EC2

        sudo pip install boto boto3
  * 微软云服务

        sudo pip install ansible[azure]
  * DigitalOcean

        sudo pip install dopy==0.3.5
  * Google

        sudo pip install "apache-libcloud>=1.17.0"
  * Linode

        sudo pip install linode-python
  * Rackspace 云

        sudo pip install pyrax
  * **特别需要注意的是如果你使用 Python** 是通过 Homebrew 安装的，还需要运行以下命令来确定找到必要的库文件

        mkdir -p ~/Library/Python/2.7/lib/python/site-packages
        echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

### 执行 ###
1. 从 Streisand 抓取源码

        git clone https://github.com/StreisandEffect/streisand.git && cd streisand
2. 执行 Streisand 脚本。

        ./streisand
3. 根据实际情况从弹出的问题中填写或选择选项，比如服务器的物理位置，它的名字。还有最重要的是 API 信息（可以从问题提示中找到如何提供 API 信息）。
4. 一旦登录信息和 API key 正确无误完成，Streisand 就开始安装到另一个 VPS 上了（或者把你目前的 VPS 变成网关）。
5. 整个配置完成大概需要10分钟左右的样子，完成后，在 Streisand 目录下会生成一个 'generated-docs' 文件夹，里面储存了4个 html 文件，其中包含了网关的 SSL 证书和如何连接的详细说明。当你使用这些方法连接上网关以后，网关里详细描述了设置客户端的方法、需要额外下载的文件，客户端镜像，密钥，只要耐心配置客户端就一切搞定了。

**译者注：到这里官方英文配置就告一段落了。译者在自己配置的过程中还遇到一些小麻烦，需要各位朋友注意。**
* 从本地用 Streisand 安装到网关的模式，如果能用这种模式最好，就不要选择其他的模式了，因为这样他生成的 generated-docs 就在本地，你用浏览器打开就能直接下载到证书文件，不折腾。
* 在 VPS 上用 Streisand 安装到新的 VPS 模式还有后面介绍的将正在运行的 VPS 转变为网关这种模式，你会发现你很难在 VPS 上阅读 generated-docs 文件夹中的4个 html 文档，这个时候有几种方法可选：
  * 使用 sftp 下载文件；
  * 在目前的 VPS 上安装一个 apache2 ，然后 cp -r generated-doc /var/www/html/ ，然后从浏览器输入 VPS 的地址直接浏览并下载密钥（严格地说，这不安全，因为不是 https 连接，如果截获了数据便可以知道如何登录你科学上网的那个网关了。**如果是使用转化那个模式，就不要用这种方法了**）。
  * 在 VPS 上使用 scp 将 generated-docs 目录全部推送到你本地暴露在公网下的 Linux, Unix 或者 macOS 里，或者另一个 VPS 里也可以。命令大概是 scp -r generated-docs user@×××.×××.×××.×××:/home/user/

### 将正在使用中的 VPS 变成 Streisand 服务器 （高级使用） ###

如果你本地使用的计算机无法运行 Streisand ，你可以将正在运行的 VPS 转变为网关。只需要在 VPS 上运行 ./streisand 并在菜单中选择 "Localhost (Advanced)" 就可以了。

**但是需要注意的是**这个操作是无法挽回的，它将把你正在使用的 VPS 完全转变为网关后，之前如果你在上面搭建博客或者用于测试某些软件，那完成这个操作后，它们将不复存在。

### 在其他的 VPS 供应商上运行 （高级使用）###

你同样可以将 Streisand 运行在其他 VPS 供应商（提供更好的硬件也没问题，奇葩的 VPS 供应商也行）的 16.04 Ubuntu 上，只需要你在运行 ./streisand 的时候选择菜单中的 "Existing Server (Advanced)" 就可以。你需要提供这个 VPS 的 IP 地址。

这个 VPS 必须使用 `$HOME/.ssh/id_rsa` 来储存 SSH key，并且可以使用 **root** 作为默认用户登录 VPS，如果提供商没有给你 root 用户作为默认用户登录，而是别的用户名，比如：`ubuntu` ，那么在运行 `./streisand` 之前需要额外配置 `ANSIBLE_SSH_USER` 环境变量，比如修改为：`ANSIBLE_SSH_USER=ubuntu` 。

### 非交互式部署 （高级使用）###

如果你想做非交互式部署, 你可以在 `global_vars/noninteractive`找到配置文件和脚本文件。你需要在配置文件或命令行录入必要信息。

将 Streisand 在 VPS 供应商上运行:

      deploy/streisand-new-cloud-server.sh \
        --provider digitalocean \
        --site-config global_vars/noninteractive/digitalocean-site.yml

将 Streisand 在正在使用中的服务器上运行:

      deploy/streisand-local.sh \
        --site-config global_vars/noninteractive/local-site.yml

将 Streisand 在已现有的服务器上运行 :

      deploy/streisand-existing-cloud-server.sh \
        --ip-address 10.10.10.10 \
        --ssh-user root \
        --site-config global_vars/noninteractive/digitalocean-site.yml

未来特性
-----------------
* 更简便的设置

如果你对 Streisand 有任何期待和想法，或者你找到 BUG ，请联系我们并且发 [Issue Tracker](https://github.com/StreisandEffect/streisand/issues) 。

核心的贡献者们
----------------
* Jay Carlson (@nopdotcom)
* Nick Clarke (@nickolasclarke)
* Joshua Lund (@jlund)
* Ali Makki (@alimakki)
* Daniel McCarney (@cpu)
* Corban Raun (@CorbanR)

相关知识
----------------
[Jason A. Donenfeld](https://www.zx2c4.com/) 凭借他的智慧和果敢重新设计一个现代的 VPN，就像我们看到的 [WireGuard](https://www.wireguard.com/) 。他非常耐心和认真的给予帮助并提供了优质的反馈，在此，向他表示我由衷的感谢。

对 [Trevor Smith](https://github.com/trevorsmith) 在项目上的付出，简直无法形容，非常感谢他，正是他提出了网关的提案，提供了数不胜数反馈，在公布前灵机一动，创建了 html 模板，让现在的**一切看上去那么屌**。

非常感谢 [Paul Wouters](https://nohats.ca/) 的 [The Libreswan Project](https://libreswan.org/) ，正是他的耐心调试和设置，才让 L2TP/IPsec 工作的那么好。

另外，[Joshua Lund](https://github.com/jlund)开始这个项目工作的时候，他差不多把 [Starcadian's](https://www.starcadian.com/) 的 'Sunset Blood' 听了300遍（译者：这张专辑节奏感不错）。
