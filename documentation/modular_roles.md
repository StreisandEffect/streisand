Modular Roles
===============

Streisand includes many services in an out-of-box install. This helps make
censorship resistance as easy as possible. In a hostile network environment the
protocols/services that are blocked can vary & change overnight. With many
choices available for connecting through a Streisand instance to clear Internet
there is likely always a choice that will work!

For use cases less focused on censorship resistance this "kitchen sink of
services" approach has two large downsides: many moving parts & a very large
externally facing attack surface.

The solution: Allowing users to selectively disable Streisand services they
don't require, creating custom profiles that suits their needs.

The challenge: Streisand was initially designed as a monolithic deploy. That is,
the Ansible roles responsible for each service inter-depend on one another. To
enable picking and choosing Streisand services while minimizing spaghetti
complexity it's necessary to eliminate cross-role dependencies.

This document aims to be a roadmap for converting roles to be stand-alone and
suitable for the goal of modularizing included services. As a concrete example
this document will discuss the Shadowsocks role, the first role that has been
converted to this style.

Rough Plan
----------

**Note**: _This is all subject to change as discussion/experience unfolds!_

1. One role at a time, convert it to be stand alone (e.g. create its own
   firewall rules, do its own client mirroring, etc).
2. Add an enable flag variable for the role, default to on (e.g. Streisand by
   default remains ship-it-all-by-default).
3. Once all roles are converted, add infrastructure for selecting roles (helper
   script modifications).
4. Discuss which roles should be enabled by default to perhaps pare down the
   base install.
5. Update this documentation.

Implementation
--------------

Each service has an enable bool variable defined in `playbooks/group_vars/all` to
control whether the service is going to be included or not. E.g.
`streisand_shadowsocks_enabled: yes` would include Shadowsocks when provisioning
a server.

Every Streisand service has to handle the following responsibilities:

* Installing & setting up server software/configurations.
* Updating firewall rules/access controls.
* Generating client connection instructions & config files.
* Mirroring client software.

For the purpose of connection instructions & client software each service has
two directories it must create & populate:

* One in `/var/www/streisand/` for connection instructions.
* One in `var/www/streisand/mirror/` for client mirroring.

Both directories should contain an `index.html` for the available Streisand
languages.

Since responsibilities between services are similar, the self-contained roles
should have roughly the same structure (minimized for brevity):

```
service/
├── meta
│   └── main.yml
├── tasks
│   ├── main.yml
│   ├── docs.yml
│   ├── firewall.yml
│   └── mirror.yml
└── vars
    ├── main.yml
    └── mirror.yml
```

* `meta/main.yml` is used for declaring dependencies (e.g. on `ufw` for
  firewall rules). Nothing special there!

* `tasks/main.yml` handles the base responsibilities of installing
  software/configs etc. and includes the subtask files: `docs.yml`,
  `firewall.yml` and `mirror.yml`.

* `tasks/docs.yml` handles generating connection instructions for the service
  under its documentation root.

* `tasks/firewall.yml` handles adding `ufw`/`iptables` rules as required by the
  service.

* `tasks/mirror.yml` handles downloading client software to the service's mirror
  root and generating any required client install documentation.

* `vars/main.yml` are the variables required for the service's configuration/etc.

* `vars/mirror.yml` are mirror-specific variables (client software versions,
   download URLs, expected hashes/signatures, etc)

For Shadowsocks, initially the `ufw` role was responsible for adding a firewall
rule for the `shadowsocks-libev` port. This created a cross-role dependency
where if the `shadowsocks` role was disabled the `ufw` role would open a port
unnecessarily, or reference a variable that didn't exist. 

To remove this cross-dependency the `shadowsocks` role was updated to declare
a meta dependency on the generic firewall role (to ensure the package is
installed and ready) in `meta/main.yml`. Then a `tasks/firewall.yml` subtask
file was added that uses `ufw` to add the required rules.

Similarly, the initial `streisand-mirror` role downloaded all of the
Shadowsocks clients for the mirror using a distinct tasks `.yml` with its own
variables `.yml`. This made it fairly easy to move the mirror subtasks from
`streisand-mirror/tasks/shadowsocks.yml` to
`shadowsocks/tasks/mirror.yml` and `streisand-mirror/vars/shadowsocks.yml` to
`shadowsocks/vars/mirror.yml`. Now the `shadowsocks` role can be responsible for
preparing its own client mirror.

Gateway & Mirror Indices
------------------------------

While the Gateway & Mirror documentation can be largely agnostic of which
services are included in a given build by outsourcing the management of
subfolders of `/var/www/streisand` and `/var/www/streisand/mirror` eventually
a consistent set of docs to navigate must be created based on the included
services. This is done by conditionally adding links to the connection
instruction & mirror indices of each subservice using the enable bool variables
in the docs and mirror index files.  This is the one place where the "if
spaghetti" is required in order to stitch things together.

As a concrete example, consider the `shadowsocks` role. Previously the
`streisand-gateway` and `streisand-mirror` roles were responsible for all
aspects of the Shadowsocks documentation & mirroring.

Now, the `shadowsocks` role creates a `/var/www/streisand/shadowsocks/`
directory and generates an `index.html` in there with connection instructions.
Similarly, the client software is mirrored to
`/var/www/streisand/mirror/shadowsocks/` and an `index.html` is generated in
there to list the available clients & their installation instructions.

The `playbooks/roles/streisand-gateway/templates/index.md.j2` index template can
conditionally generate a link to the installation instructions:

```
{% if streisand_shadowsocks_enabled %}
* [Shadowsocks](/shadowsocks/)
{% endif %}
```

Similarly, the index can conditionally generate a link to the service client mirror:

```
{% if streisand_shadowsocks_enabled %}
* [Shadowsocks](/mirror/shadowsocks/)
{% endif %}
```

The same approach is taken in the mirror index template:
`playbooks/roles/streisand-mirror/templates/mirror-index.md.j2`.

Common Daemon Config
------------------------

Some Streisand services have to modify base daemon configurations in order to
provide services like DNS/DHCP to interfaces they create. Where possible we
should strive to avoid having centralized "monolith" configurations and instead
use the "config.d/" approach to allow modular configuration of these shared
daemons. The [original usecase](https://lists.debian.org/debian-devel/2010/04/msg00352.html)
for these directories closely matches the situation Streisand is in:

    Once upon a time, most UNIX software was controlled by a single
    configuration file per software package, and all the configuration details
    for that package went into that file.  This worked reasonably well when
    that file was hand-crafted by the system administrator for local needs.

    When distribution packaging became more and more common, it became clear
    that we needed better ways of forming such configuration files out of
    multiple fragments, often provided by multiple independent packages.  Each
    package that needs to configure some shared service should be able to
    manage only its configuration without having to edit a shared
    configuration file used by other packages.

    The most common convention adopted was to permit including a directory
    full of configuration files, where anything dropped into that directory
    would become active and part of that configuration.

A concrete example of this common daemon problem is the `dnsmasq` service/role
and its interactions with the `wireguard` and `openvpn` roles. Prior to
modularization the `dnsmasq` role made sure the daemon listened on all required
intefaces by having one `/etc/dnsmasq.conf` config file generated by the
`dnsmasq` role's `dnsmasq.conf.j2` template. The template had one
`listen-address` configuration parameter that listed all of the interface
addresses in a comma-separated form:

```
listen-address=127.0.0.1,{{ dnsmasq_openvpn_tcp_ip }},{{ dnsmasq_openvpn_udp_ip }},{{ dnsmasq_wireguard_ip }}
```

This meant that if the `openvpn` or `wireguard` roles were disabled/removed the
template for the `dnsmasq` config would fail due to the missing variables.

The approach used to fix this was to have the base `/etc/dnsmasq.conf` file
specify only `listen-address=127.0.0.1` and update the `openvpn` and `wireguard`
roles to write their own `listen-address` fragments from a template to their own
config files in `/etc/dnsmasq.d/`. Now the `dnsmasq` role is decoupled from the
`openvpn` and `wireguard` roles that can be added/removed at will.

