Streisand PKI
=============

Streisand includes a role responsible for PKI certificate generation,
separated into two distinct tasks:

 - CA/Server
 - Client(s)

The first will generate a certificate authority, and a server 
certificate signed by the newly minted certificate authority.

The latter task is responsible for generating client side certificates
(using the same CA) used for authenticating connecting VPN clients.

Each VPN service that leverages the Streisand PKI generates its
own CA/Server certificate and client certificates.

Infrastructure
--------------

The overall PKI infrastructure assumes the following structure:

```
Web Root CA: 
   \__ gateway HTTPS cert (unless Let's Encrypt; see below)

OpenConnect CA: 
   \__ OpenConnect server cert
   \__ OpenConnect client 1
   \__ OpenConnect client ...
   \__ OpenConnect client n

OpenVPN CA: 
   \__ OpenVPN server cert
   \__ OpenVPN client 1
   \__ OpenVPN client ...
   \__ OpenVPN client n

ISRG X1:
   \__ Let's Encrypt Authority X3
        \__ streisand.example.com HTTPS cert
``` 

Usage
-----

Utilizing the `certificates` role can be invoked as follows (using OpenVPN as an example):
(If client certificates need to be generated, a directory for each client must be created
first)

```
- name: Create directories for clients # needed if client certificates are required
  file:
    path: "/etc/openvpn/{{ client_name.stdout }}"
    state: directory
  with_items: "{{ vpn_client_names.results }}"
  loop_control:
    loop_var: "client_name"
    label: "{{ client_name.item }}"

- include_role:
    name: certificates
  vars:
    ca_path:            "/etc/openvpn"
    tls_ca:             "/etc/openvpn/ca"
    tls_client_path:    "/etc/openvpn"
    generate_ca_server: yes
    generate_client:    yes
    tls_request_subject:         "/C=US/ST=California/L=Beverly Hills/O=ACME CORPORATION/OU=Anvil Department"
    tls_server_common_name_file: "/etc/openvpn/openvpn-common-name.txt"
    tls_sans:                    # sets the Subject Alternative Name(s) attribute(s)
      - "1.2.3.4"
      - "5.6.7.8"
```

Note the following flags:
 - `generate_ca_server: yes`
 - `generate_client: yes`

 These must be made explicit, as the default value is `no`; certificates should not be generated unless
 they have to be.

The certificates role makes certain assumptions with regards to default values,
all of which can be inspected [here](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/certificates/defaults/main.yml).

