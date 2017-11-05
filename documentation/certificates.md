Streisand PKI
=============

Streisand includes a role responsible for PKI certificate generation,
separated into three heirarchical tasks:

```
CA/Server
   \__ CA Certificate
     \__ Server certificate
    \__ Client (1..n)
      \__ Client PKCS (1..n)
 
```

CA/Server
---------
Guarded by `generate_ca_server: yes`

Generate a certificate authority, and a server 
certificate signed by the newly minted certificate authority.

Client
------
Generate client certificates using the CA from `generate_ca_server: yes`. 
These client certificates can be used by VPN clients to authenticate with 
VPN services on the server.

Client (PKCS#11 format)
-----------------------
Guarded by `generate_pkcs: yes`

Also convert client certificates into PKCS#12 format.

Infrastructure
--------------

Note: Each VPN service that invokes the certificates role will generate it's own 
distinct public key infrastructure.

The overall Streisand PKI infrastructure assumes the following structure:

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

The `certificates` role can be invoked as follows (using OpenVPN as an example, with variables expanded for brevity):

```
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
 - `generate_pkcs: yes`

 These must be made explicit, as the default value is `no`; certificates should not be generated unless
 they have to be.

The certificates role makes certain assumptions with regards to default values,
all of which can be inspected [here](https://github.com/StreisandEffect/streisand/blob/master/playbooks/roles/certificates/defaults/main.yml).

