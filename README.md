![Streisand Logo](https://missingm.co/streisand.jpg "Automate the effect")

Streisand
=========

**Silence censorship. Automate the [effect](https://en.wikipedia.org/wiki/Streisand_effect).**

The Internet can be a little unfair. It's way too easy for ISPs, telecoms, politicians, and corporations to block access to the sites and information that you care about. But breaking through these restrictions is *tough*. Or is it?

Introducing Streisand
---------------------
* A single command sets up a brand new server running a [wide variety of anti-censorship software](#services-provided) that can completely mask and encrypt all of your Internet traffic.
* Streisand natively supports the creation of new servers at [Amazon EC2](https://aws.amazon.com/ec2/), [DigitalOcean](https://www.digitalocean.com/), [Linode](https://www.linode.com/), and [Rackspace](https://www.rackspace.com/)&mdash;with more providers coming soon! It also runs on any Debian 7 server regardless of provider, and **hundreds** of instances can be configured simultaneously using this method.
* The process is completely automated and only takes about ten minutes, which is pretty awesome when you consider that it would require the average system administrator several days of frustration to set up even a small subset of what Streisand offers in its out-of-the-box configuration.
* Once your Streisand server is running, you can give the custom connection instructions to friends, family members, and fellow activists. The connection instructions contain an embedded copy of the server's unique SSL certificate, so you only have to send them a single file.
* Each server is entirely self-contained and comes with absolutely everything that users need to get started, including cryptographically verified mirrors of all common clients. This renders any attempted censorship of default download locations completely ineffective.
* But wait, there's more...

More Features
-------------
* Nginx powers a password-protected and encrypted Gateway that serves as the starting point for new users. The Gateway is accessible over SSL, or as a Tor [hidden service](https://www.torproject.org/docs/hidden-services.html.en).
  * Beautiful, custom, step-by-step client configuration instructions are generated for each new server that Streisand creates. Users can quickly access these instructions through any web browser. The instructions are responsive and look fantastic on mobile phones:

    ![Streisand Screenshot](https://missingm.co/streisand-mobile-screenshot.png "Gateway")
  * The integrity of mirrored software is ensured using SHA-256 checksums, or by verifying GPG signatures if the project provides them. This protects users from downloading corrupted files.
  * All ancillary files, such as OpenVPN configuration profiles, are also available via the Gateway.
  * Current Tor users can take advantage of the additional services Streisand sets up in order to transfer large files or to handle other traffic (e.g. BitTorrent) that isn't appropriate for the Tor network.
  * A unique password, SSL certificate, and SSL private key are generated for each Streisand Gateway. The Gateway instructions and certificate are transferred via SSH at the conclusion of Streisand's execution.
* Distinct services and multiple daemons provide an enormous amount of flexibility. If one connection method gets blocked there are numerous options available, most of which are resistant to Deep Packet Inspection.
  * All of the connection methods (including L2TP/IPsec and direct OpenVPN connections) are effective against the type of blocking Turkey has been experimenting with.
  * OpenSSH, OpenVPN (wrapped in stunnel), Shadowsocks, and Tor (with obfsproxy and the obfs3 or ScrambleSuit pluggable transports) are all currently effective against China's Great Firewall.
* Every task has been thoroughly documented and given a detailed description. Streisand is simultaneously the most complete HOWTO in existence for the setup of all of the software it installs, and also the antidote for ever having to do any of this by hand again.
* All software runs on ports that have been deliberately chosen to make simplistic port blocking unrealistic without causing massive collateral damage. OpenVPN, for example, does not run on its default port of 1194, but instead uses port 636, the standard port for LDAP/SSL connections that are beloved by companies worldwide.
  * *L2TP/IPsec is a notable exception to this rule because the ports cannot be changed without breaking client compatibility*
* The IP addresses of connecting clients are never logged. There's nothing to find if a server gets seized or shut down.

<a name="services-provided"></a>
Services Provided
-----------------
* L2TP/IPsec using [strongSwan](https://strongswan.org/) and [xl2tpd](https://www.xelerance.com/software/xl2tpd/)
  * A randomly chosen pre-shared key and password are generated.
  * Windows, OS X, Android, and iOS users can all connect using the native VPN support that is built into each operating system without installing any additional software.
  * *Streisand does not install L2TP/IPsec on Amazon EC2 servers by default because the instances cannot bind directly to their public IP addresses which makes IPsec routing nearly impossible.*
* [OpenSSH](http://www.openssh.com/)
  * An unprivileged forwarding user and SSH keypair are generated for [sshuttle](https://github.com/apenwarr/sshuttle) and SOCKS capabilities. Windows and Android SSH tunnels are also supported, and a copy of the keypair is exported in the .ppk format that PuTTY requires.
  * [Tinyproxy](https://banu.com/tinyproxy/) is installed and bound to localhost. It can be accessed over an SSH tunnel by programs that do not natively support SOCKS and that require an HTTP proxy, such as Twitter for Android.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * Self-contained "unified" .ovpn profiles are generated for easy client configuration using only a single file.
  * Multiple clients can easily share the same certificates and keys, but five separate sets are generated by default.
  * Client DNS resolution is handled via [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) to prevent DNS leaks.
  * TLS Authentication is enabled which helps protect against active probing attacks. Traffic that does not have the proper HMAC is simply dropped.
* [Shadowsocks](http://shadowsocks.org/en/index.html)
  * The [Dante](https://www.inet.no/dante/) proxy server is set up as a workaround for a [bug](https://bugzilla.mozilla.org/show_bug.cgi?id=947801) in Firefox for Android.
  * A QR code is generated that can be used to automatically configure the Android and iOS clients by simply taking a picture. You can tag '8.8.8.8' on that concrete wall, or you can glue the Shadowsocks instructions and some QR codes to it instead!
* [sslh](http://www.rutschle.net/tech/sslh.shtml)
  * Sslh is a protocol demultiplexer that allows Nginx, OpenSSH, and OpenVPN to share port 443. This provides an alternative connection option and means that you can still route traffic via OpenSSH and OpenVPN even if you are on a restrictive network that blocks all access to non-HTTP ports.
* [Stunnel](https://www.stunnel.org/index.html)
  * Listens for and wraps OpenVPN connections. This makes them look like standard SSL traffic and allows OpenVPN clients to successfully establish tunnels even in the presence of Deep Packet Inspection.
  * Unified profiles for stunnel-wrapped OpenVPN connections are generated alongside the direct connection profiles. Detailed instructions are also generated.
  * The stunnel certificate and key are exported in PKCS #12 format so they are compatible with other SSL tunneling applications. Notably, this enables [OpenVPN for Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn) to tunnel its traffic through [SSLDroid](https://play.google.com/store/apps/details?id=hu.blint.ssldroid). OpenVPN in China on a mobile device? Yes!
* [Tor](https://www.torproject.org/)
  * A [bridge relay](https://www.torproject.org/docs/bridges) is set up with a random nickname.
  * [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) is installed and configured, including support for the obfs3 and [ScrambleSuit](http://www.cs.kau.se/philwint/scramblesuit/) pluggable transports.

Installation
------------

### Prerequisites ###
* Streisand requires a BSD, Linux, or OS X system. All of the following commands should be run inside a Terminal session.
* Python 2.7 is required. This comes standard on OS X, and is the default on almost all Linux and BSD distributions as well. If your distribution packages Python 3 instead, you will need to install version 2.7 in order for Streisand to work properly.
* Make sure an SSH key is present in ~/.ssh/id\_rsa.pub.
  * If you do not have an SSH key, you can generate one by using this command and following the defaults:

            ssh-keygen
* Install Git.
  * On Debian and Ubuntu

            sudo apt-get install git
  * On Fedora

            sudo yum install git
  * On OS X (via [Homebrew](http://brew.sh/))

            brew install git
* Install the [pip](https://pip.pypa.io/en/latest/) package management system for Python.
  * On Debian and Ubuntu (also installs the dependencies that are necessary to build Ansible)

            sudo apt-get install python-pip python-dev build-essential
  * On Fedora

            sudo yum install python-pip
  * On OS X

            sudo easy_install pip
* Install [Ansible](http://www.ansible.com/home). If you have an existing installation, please note that Ansible version 1.7+ is required.
  * On OS X (via [Homebrew](http://brew.sh/))

            brew install ansible
  * On OS X Mavericks (via pip)

            sudo CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments pip install ansible
  * On BSD, Linux, or earlier versions of OS X (via pip)

            sudo pip install ansible markupsafe
* Install the necessary Python libraries for your chosen cloud provider if you are going to take advantage of Streisand's ability to create new servers using a supported API.
  * Amazon EC2

            sudo pip install boto
  * DigitalOcean

            sudo pip install dopy
  * Linode

            sudo pip install linode-python
  * Rackspace Cloud

            sudo pip install pyrax
  * If you are using a Homebrew-installed version of Python you should also run these commands to make sure it can find the necessary libraries:

            mkdir -p ~/Library/Python/2.7/lib/python/site-packages
            echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

### Execution ###
1. Clone the Streisand repository and enter the directory.

        git clone https://github.com/jlund/streisand.git && cd streisand
2. Execute the Streisand script.

        ./streisand
3. Follow the prompts to choose your provider, the physical region for the server, and its name. You will also be asked to enter API information.
4. Wait for the setup to complete (this usually takes around ten minutes) and look for the corresponding files in the 'generated-docs' folder in the Streisand repository directory. The HTML file will explain how to connect to the Gateway over SSL, or via the Tor hidden service. All instructions, files, mirrored clients, and keys for the new server can then be found on the Gateway. You are all done!

You can also run Streisand on any number of new Debian 7 servers. Dedicated hardware? Great! Esoteric cloud provider? Awesome! To do this, simply edit the `inventory` file and uncomment the final two lines. Replace the sample IP with the address (or addresses) of the servers you wish to configure. Make sure you read through all of the documentation in the `inventory` file and update the `ansible.cfg` file if necessary. Then run the Streisand playbook directly:

    ansible-playbook playbooks/streisand.yml

The servers should be accessible using SSH keys, and *root* is used as the connecting user by default (though this is simple to change by updating the streisand.yml file or ansible.cfg file).

Upcoming Features
-----------------
* Native [Microsoft Azure](https://azure.microsoft.com/en-us/) support
* Native [Google Compute Engine](https://cloud.google.com/products/compute-engine/) support
* A flag to allow L2TP/IPsec installation to be disabled
* Creation of a Streisand pip package to make the setup of all required dependencies even easier
* Output of firewall configuration information for users who would like to run Streisand on their own hardware
* Automatic security upgrades

If there is something that you think Streisand should do, or if you find a bug in its documentation or execution, please file a report on the [Issue Tracker](https://github.com/jlund/streisand/issues).

Acknowledgements
----------------
I cannot express how grateful I am to [Trevor Smith](https://github.com/trevorsmith) for his massive contributions to the project. He suggested the Gateway approach, provided tons of invaluable feedback, made *everything* look better, and developed the HTML template that served as the inspiration to take things to the next level before Streisand's public release. I also appreciated the frequent use of his iPhone while testing various clients.

Huge thanks to [Paul Wouters](https://nohats.ca/) of [The Libreswan Project](https://libreswan.org/) for his generous help troubleshooting the L2TP/IPsec setup.

[Corban Raun](https://github.com/CorbanR) was kind enough to lend me a Windows laptop that let me test and refine the instructions for that platform, and he was a big supporter of the project from the very beginning.

I also listened to [Starcadian's](http://starcadian.com/) 'Sunset Blood' album approximately 300 times on repeat while working on this.
