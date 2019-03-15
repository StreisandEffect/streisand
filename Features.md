# Features

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
