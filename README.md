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

**Silence censorship. Automate the [effect](https://en.wikipedia.org/wiki/Streisand_effect).**

The Internet can be a little unfair. It's way too easy for ISPs, telecoms, politicians, and corporations to block access to the sites and information that you care about. But breaking through these restrictions is *tough*. Or is it?

Introducing Streisand
---------------------
* A single command sets up a brand new Ubuntu 16.04 server running a [wide variety of anti-censorship software](#services-provided) that can completely mask and encrypt all of your Internet traffic.
* Streisand natively supports the creation of new servers at [Amazon EC2](https://aws.amazon.com/ec2/), [Azure](https://azure.microsoft.com), [DigitalOcean](https://www.digitalocean.com/), [Google Compute Engine](https://cloud.google.com/compute/), [Linode](https://www.linode.com/), and [Rackspace](https://www.rackspace.com/)&mdash;with more providers coming soon! It also runs on any Ubuntu 16.04 server regardless of provider, and **hundreds** of instances can be configured simultaneously using this method.
* The process is completely automated and only takes about ten minutes, which is pretty awesome when you consider that it would require the average system administrator several days of frustration to set up even a small subset of what Streisand offers in its out-of-the-box configuration.
* Once your Streisand server is running, you can give the custom connection instructions to friends, family members, and fellow activists. The connection instructions contain an embedded copy of the server's unique SSL certificate, so you only have to send them a single file.
* Each server is entirely self-contained and comes with absolutely everything that users need to get started, including cryptographically verified mirrors of all common clients. This renders any attempted censorship of default download locations completely ineffective.
* But wait, there's more...

More Features
-------------
* Nginx powers a password-protected and encrypted Gateway that serves as the starting point for new users. The Gateway is accessible over SSL, or as a Tor [hidden service](https://www.torproject.org/docs/hidden-services.html.en).
  * Beautiful, custom, step-by-step client configuration instructions are generated for each new server that Streisand creates. Users can quickly access these instructions through any web browser. The instructions are responsive and look fantastic on mobile phones.
  * The integrity of mirrored software is ensured using SHA-256 checksums, or by verifying GPG signatures if the project provides them. This protects users from downloading corrupted files.
  * All ancillary files, such as OpenVPN configuration profiles, are also available via the Gateway.
  * Current Tor users can take advantage of the additional services Streisand sets up in order to transfer large files or to handle other traffic (e.g. BitTorrent) that isn't appropriate for the Tor network.
  * A unique password, SSL certificate, and SSL private key are generated for each Streisand Gateway. The Gateway instructions and certificate are transferred via SSH at the conclusion of Streisand's execution.
* Distinct services and multiple daemons provide an enormous amount of flexibility. If one connection method gets blocked there are numerous options available, most of which are resistant to Deep Packet Inspection.
  * All of the connection methods (including direct OpenVPN connections) are effective against the type of blocking Turkey has been experimenting with.
  * OpenConnect/AnyConnect, OpenSSH, OpenVPN (wrapped in stunnel), Shadowsocks, Tor (with obfsproxy and the obfs4 pluggable transport), and WireGuard are all currently effective against China's Great Firewall.
* Every task has been thoroughly documented and given a detailed description. Streisand is simultaneously the most complete HOWTO in existence for the setup of all of the software it installs, and also the antidote for ever having to do any of this by hand again.
* All software runs on ports that have been deliberately chosen to make simplistic port blocking unrealistic without causing massive collateral damage. OpenVPN, for example, does not run on its default port of 1194, but instead uses port 636, the standard port for LDAP/SSL connections that are beloved by companies worldwide.

<a name="services-provided"></a>
Services Provided
-----------------

* [OpenSSH](https://www.openssh.com/)
  * Windows and Android SSH tunnels are also supported, and a copy of the keypair is exported in the .ppk format that PuTTY requires.
  * [Tinyproxy](https://banu.com/tinyproxy/) is installed and bound to localhost. It can be accessed over an SSH tunnel by programs that do not natively support SOCKS and that require an HTTP proxy, such as Twitter for Android.
  * An unprivileged forwarding user and SSH keypair are generated for [sshuttle](https://github.com/sshuttle/sshuttle) and SOCKS capabilities.
* [OpenConnect](https://ocserv.gitlab.io/www/index.html) / [Cisco AnyConnect](https://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * OpenConnect (ocserv) is an extremely high-performance and lightweight VPN server that also features full compatibility with the official Cisco AnyConnect clients.
  * The [protocol](https://ocserv.gitlab.io/www/technical.html) is built on top of standards like HTTP, TLS, and DTLS, and it's one of the most popular and widely used VPN technologies among large multi-national corporations.
    * This means that in addition to its ease-of-use and speed, OpenConnect is also highly resistant to censorship and is almost never blocked.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * Self-contained "unified" .ovpn profiles are generated for easy client configuration using only a single file.
  * Both TCP and UDP connections are supported.
  * Client DNS resolution is handled via [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) to prevent DNS leaks.
  * TLS Authentication is enabled which helps protect against active probing attacks. Traffic that does not have the proper HMAC is simply dropped.
* [Shadowsocks](https://shadowsocks.org/en/index.html)
  * The high-performance [libev variant](https://github.com/shadowsocks/shadowsocks-libev) is installed. This version is capable of handling thousands of simultaneous connections.
  * A QR code is generated that can be used to automatically configure the Android and iOS clients by simply taking a picture. You can tag '8.8.8.8' on that concrete wall, or you can glue the Shadowsocks instructions and some QR codes to it instead!
  * [AEAD](https://shadowsocks.org/en/spec/AEAD-Ciphers.html) support is enabled using ChaCha20 and Poly1305 for enhanced security and improved GFW evasion.
  * The [simple-obfs](https://github.com/shadowsocks/simple-obfs) plugin is installed to provide robust traffic evasion on hostile networks (especially those implementing quality of service (QOS) throttling).
* [sslh](https://www.rutschle.net/tech/sslh/README.html)
  * Sslh is a protocol demultiplexer that allows Nginx, OpenSSH, and OpenVPN to share port 443. This provides an alternative connection option and means that you can still route traffic via OpenSSH and OpenVPN even if you are on a restrictive network that blocks all access to non-HTTP ports.
* [Stunnel](https://www.stunnel.org/index.html)
  * Listens for and wraps OpenVPN connections. This makes them look like standard SSL traffic and allows OpenVPN clients to successfully establish tunnels even in the presence of Deep Packet Inspection.
  * Unified profiles for stunnel-wrapped OpenVPN connections are generated alongside the direct connection profiles. Detailed instructions are also generated.
  * The stunnel certificate and key are exported in PKCS #12 format so they are compatible with other SSL tunneling applications. Notably, this enables [OpenVPN for Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn) to tunnel its traffic through [SSLDroid](https://play.google.com/store/apps/details?id=hu.blint.ssldroid). OpenVPN in China on a mobile device? Yes!
* [Tor](https://www.torproject.org/)
  * A [bridge relay](https://www.torproject.org/docs/bridges) is set up with a random nickname.
  * [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) is installed and configured with support for the obfs4 pluggable transport.
  * A BridgeQR code is generated that can be used to automatically configure [Orbot](https://play.google.com/store/apps/details?id=org.torproject.android) for Android.
* [UFW](https://wiki.ubuntu.com/UncomplicatedFirewall)
  * Firewall rules are configured for every service, and any traffic that is sent to an unauthorized port will be blocked.
* [unattended-upgrades](https://help.ubuntu.com/community/AutomaticSecurityUpdates)
  * Your Streisand server is configured to automatically install new security updates.
* [WireGuard](https://www.wireguard.com/)
  * Linux users can take advantage of this next-gen, simple, kernel-based, state-of-the-art VPN that also happens to be ridiculously fast and uses modern cryptographic principles that all other highspeed VPN solutions lack.

Installation
------------
Please read all installation instructions **carefully** before proceeding.

### Important Clarification ###
Streisand is based on [Ansible](https://www.ansible.com/), an automation tool that is typically used to provision and configure files and packages on remote servers. Streisand automatically sets up **another remote server** with the VPN packages and configuration.

Streisand will spin up and deploy **another server** on your chosen hosting provider when you run **on your home machine** (e.g. your laptop). Usually, you **do not run Streisand on the remote server** as by default this would result in the deployment of another server from your server and render the first server redundant (whew!).

In some circumstances advanced users may opt to use the local provisioning mode to have the system running Streisand/Ansible configure itself as a Streisand server. This is a configuration mode best reserved for when it isn't possible to install Ansible on your home machine or when your connection to a cloud provider is too unreliable for Ansible's SSH connections.

### Prerequisites ###
Complete all of these tasks on your local home machine.

* Streisand requires a BSD, Linux, or macOS system. As of now, Windows is not supported. All of the following commands should be run inside a Terminal session.
* Python 2.7 is required. This comes standard on macOS, and is the default on almost all Linux and BSD distributions as well. If your distribution packages Python 3 instead, you will need to install version 2.7 in order for Streisand to work properly.
* Make sure an SSH public key is present in ~/.ssh/id\_rsa.pub.
  * SSH keys are a more secure alternative to passwords that allow you to prove your identity to a server or service built on public key cryptography. The public key is something that you can give to others, whereas the private key should be kept secret (like a password).
  * To check if you already have an SSH public key, please enter the following command at a command prompt.
  
        ls ~/.ssh
  * If you see an id_rsa.pub file, then you have an SSH public key.
  * If you do not have an SSH key pair, you can generate one by using this command and following the defaults:

        ssh-keygen
  * If you'd like to use an SSH key with a different name or in a non-standard location, please enter 'yes' when asked if you'd like to customize your instance during installation.
  * **Please note**: You will need these keys to access your Streisand instance over SSH. Please keep them for the lifetime of the Streisand server.
* Install Git.
  * On Debian and Ubuntu

        sudo apt-get install git
  * On Fedora

        sudo yum install git
  * On macOS (via [Homebrew](https://brew.sh/))

        brew install git
* Install the [pip](https://pip.pypa.io/en/latest/) package management system for Python.
  * On Debian and Ubuntu (also installs the dependencies that are necessary to build Ansible and that are required by some modules)

        sudo apt-get install python-paramiko python-pip python-pycurl python-dev build-essential
  * On Fedora

        sudo yum install python-pip
  * On macOS

        sudo easy_install pip
        sudo pip install pycurl

* Install [Ansible](https://www.ansible.com/).
  * On macOS (via [Homebrew](https://brew.sh/))

        brew install ansible
  * On BSD or Linux (via pip)

        sudo pip install ansible markupsafe
* Install the necessary Python libraries for your chosen cloud provider. If you
    are using the advanced local provisioning mode or the existing server mode
    you can skip this section.
  * Amazon EC2

        sudo pip install boto boto3
  * Azure

        sudo pip install ansible[azure]
  * DigitalOcean

        sudo pip install dopy==0.3.5
  * Google

        sudo pip install "apache-libcloud>=1.17.0"

  * Linode

        sudo pip install linode-python
  * Rackspace Cloud

        sudo pip install pyrax
  * **Important note if you are using a Homebrew-installed version of Python** you should also run these commands to make sure it can find the necessary libraries:

        mkdir -p ~/Library/Python/2.7/lib/python/site-packages
        echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

### Execution ###
1. Clone the Streisand repository and enter the directory.

       git clone https://github.com/StreisandEffect/streisand.git && cd streisand

2. Execute the Streisand script.

       ./streisand
3. Follow the prompts to choose your provider, the physical region for the server, and its name. You will also be asked to enter API information.
4. Once login information and API keys are entered, Streisand will begin spinning up a new remote server.
5. Wait for the setup to complete (this usually takes around ten minutes) and look for the corresponding files in the 'generated-docs' folder in the Streisand repository directory. The HTML file will explain how to connect to the Gateway over SSL, or via the Tor hidden service. All instructions, files, mirrored clients, and keys for the new server can then be found on the Gateway. You are all done!

### Running Streisand to Provision Localhost (Advanced) ###

If you can not run Streisand in the normal manner (running from your client home machine/laptop to configure a remote server) Streisand supports a local provisioning mode. Simply choose "Localhost (Advanced)" from the menu after running `./streisand`.

**Note:** Running Streisand against localhost can be a destructive action! You will be potentially overwriting configuration files and must be certain that you are affecting the correct machine.

### Running Streisand on Other Providers (Advanced) ###

You can also run Streisand on a new Ubuntu 16.04 server. Dedicated hardware? Great! Esoteric cloud provider? Awesome! To do so, simply choose "Existing Server (Advanced)" from the menu after running `./streisand` and provide the IP address of the existing server when prompted.

The server must be accessible using the `$HOME/.ssh/id_rsa` SSH Key, and **root** is used as the connecting user by default. If your provider requires you to SSH with a different user than root (e.g. `ubuntu`) specify the `ANSIBLE_SSH_USER` environmental variable (e.g. `ANSIBLE_SSH_USER=ubuntu`) when you run `./streisand`.

**Note:** Running Streisand against an existing server can be a destructive action! You will be potentially overwriting configuration files and must be certain that you are affecting the correct machine.

### Noninteractive Deployment (Advanced) ###

Alternative scripts and configuration file examples are provided for
noninteractive deployment, in which all of the required information is passed
on the command line or in a configuration file.

Example configuration files are found under `global_vars/noninteractive`. Copy
and edit the desired parameters, such as providing API tokens and other choices,
and then run the appropriate script.

To deploy a new Streisand server:

      deploy/streisand-new-cloud-server.sh \
        --provider digitalocean \
        --site-config global_vars/noninteractive/digitalocean-site.yml

To run the Streisand provisioning on the local machine:

      deploy/streisand-local.sh \
        --site-config global_vars/noninteractive/local-site.yml

To run the Streisand provisioning against an existing server:

      deploy/streisand-existing-cloud-server.sh \
        --ip-address 10.10.10.10 \
        --ssh-user root \
        --site-config global_vars/noninteractive/digitalocean-site.yml

Upcoming Features
-----------------
* Easier setup.

If there is something that you think Streisand should do, or if you find a bug in its documentation or execution, please file a report on the [Issue Tracker](https://github.com/StreisandEffect/streisand/issues).

Core Contributors
----------------
* Jay Carlson (@nopdotcom)
* Nick Clarke (@nickolasclarke)
* Joshua Lund (@jlund)
* Ali Makki (@alimakki)
* Daniel McCarney (@cpu)
* Corban Raun (@CorbanR)

Acknowledgements
----------------
[Jason A. Donenfeld](https://www.zx2c4.com/) deserves a lot of credit for being brave enough to reimagine what a modern VPN should look like and for coming up with something as good as [WireGuard](https://www.wireguard.com/). He has our sincere thanks for all of his patient help and high-quality feedback.

We are grateful to [Trevor Smith](https://github.com/trevorsmith) for his massive contributions. He suggested the Gateway approach, provided tons of invaluable feedback, made *everything* look better, and developed the HTML template that served as the inspiration to take things to the next level before Streisand's public release.

Huge thanks to [Paul Wouters](https://nohats.ca/) of [The Libreswan Project](https://libreswan.org/) for his generous help troubleshooting the L2TP/IPsec setup.

[Starcadian's](https://www.starcadian.com/) 'Sunset Blood' album was played on repeat approximately 300 times during the first few months of work on the project in early 2014.
