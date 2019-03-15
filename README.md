# Streisand

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

If you have an account with a cloud computing provider, Streisand can set up a new node with many censorship-resistant VPN services nearly automatically. You'll need a little experience with a Unix command-line. (But without Streisand, it could take days for a skilled Unix administrator to configure these services securely!) At the end, you'll have a private website with software and instructions.

Here's what **[a sample Streisand server](http://streisandeffect-demo.s3-website.us-east-2.amazonaws.com/)** looks like.


There's a [list of supported cloud providers](#cloud-providers); experts may be able to use Streisand to install on many other cloud providers.

## VPN services

One type of tool that people use to avoid network censorship is a Virtual Private Network (VPN). There are many kinds of VPNs.

Not all network censorship is alike; in some places, it changes from day to day. Streisand provides many different VPN services to try. (You don't have to install them all, though.)

Some Streisand services include add-ons for further censorship and throttling resistance:

* [OpenSSH](https://www.openssh.com/)
    * [Tinyproxy](https://banu.com/tinyproxy/) may be used as an HTTP proxy.
* [OpenConnect](https://ocserv.gitlab.io/www/index.html) / [Cisco AnyConnect](https://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
    * This protocol is widely used by multi-national corporations, and might not be blocked.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
    * [Stunnel](https://www.stunnel.org/index.html) add-on available.
* [Shadowsocks](https://shadowsocks.org/en/index.html), 
    * [simple-obfs](https://github.com/shadowsocks/simple-obfs) add-on available.
* A private [Tor](https://www.torproject.org/) bridge relay
    * [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) with obfs4 available as an add-on.
* [WireGuard](https://www.wireguard.com/), a modern high-performance protocol.

See also:
* A [more technical list of features](Features.md) 
* A [more technical list of services](Services.md)

<a id="cloud-providers"></a>
## Cloud providers
* Amazon Web Services (AWS)
* Microsoft Azure
* Digital Ocean
* Google Compute Engine (GCE)
* Linode
* Rackspace


#### Other providers
We recommend using one of the above providers. If you are an expert and can set up a *fresh Ubuntu 16.04 server* elsewhere, there are "localhost" and "existing remote server" installation methods. For more information, see [the advanced installation instructions](Advanced%20installation.md).

## Installation

You need command-line access to a Unix system. You can use Linux, BSD, or macOS; on Windows 10, the Windows Subsystem for Linux (WSL) counts as Linux. 

Once you're ready, see the [full installation instructions](Installation.md).


## Things we want to do better

Aside from a good deal of cleanup, we could really use:

* Easier setup.
* Faster adoption of new censorship-avoidance tools

We're looking for help with both.

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
