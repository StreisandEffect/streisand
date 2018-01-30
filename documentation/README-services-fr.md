<a name="services-provided"></a>
Services fournis
----------------
* L2TP/IPsec en utilisant [Libreswan](https://libreswan.org/) et [xl2tpd](https://www.xelerance.com/software/xl2tpd/)
  * Une clé et un mot de passe pré-partagés choisis au hasard sont générés.
  * Les utilisateurs Windows, macOS, Androïde et iOS peuvent tous se connecter en utilisant le support VPN natif intégré à chaque système d'exploitation sans installer de logiciel supplémentaire.
* [Monit](https://mmonit.com/monit/)
  * Surveille la santé du processus et redémarre automatiquement les services dans le cas improbable où ils se plante ou ne répondent pas.
* [OpenSSH](http://www.openssh.com/)
  * Les tunnels Windows et Androïde SSH sont également pris en charge et une copie des clés sont exportée dans le format .ppk que PuTTY requiert.
  * [Tinyproxy](https://banu.com/tinyproxy/) est installé et lié à localhost. Il peut être accédé sur un tunnel SSH par des programmes qui ne prennent pas en charge nativement SOCKS et qui nécessitent un proxy HTTP, comme Twitter pour Androïde.
  * Un utilisateur de transfert non privilégié et une paire paire de clés asymétriques SSH sont générés pour les fonctionnalités [sshuttle](https://github.com/sshuttle/sshuttle) et SOCKS.
* [OpenConnect](http://www.infradead.org/ocserv/index.html)/[Cisco AnyConnect](http://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * OpenConnect (ocserv) est un serveur VPN extrêmement performant et léger qui offre également une compatibilité totale avec les clients officiels Cisco AnyConnect.
  * Le [protocole](http://www.infradead.org/ocserv/technical.html) est bâti sur des standards comme HTTP, TLS et DTLS, et c'est l'une des technologies VPN les plus populaires et largement utilisées parmi des grands entreprises multi-nationales.
    * Cela signifie qu'en plus de sa facilité d'utilisation et de sa rapidité, OpenConnect est également très résistant à la censure et presque jamais bloqué.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * Des profils autonome "unifiés" .ovpn sont générés pour une configuration de client facile en utilisant un seul fichier.
  * Les connexions TCP et UDP sont prises en charge.
  * La résolution DNS du client est gérée via [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) pour empêcher les fuites DNS.
  * L'authentification TLS est activée, ce qui permet de vous protéger contre les attaques actives. Le trafic qui n'a pas de HMAC approprié est simplement abandonné.
* [Shadowsocks](http://shadowsocks.org/en/index.html)
  * La [variante libev](https://github.com/shadowsocks/shadowsocks-libev) haute performance est installée. Cette version est capable de gérer des milliers de connexions simultanées.
  * Un code QR est généré qui peut être utilisé pour configurer automatiquement les clients Androïde et iOS en prenant simplement une photo. Vous pouvez étiqueter "8.8.8.8" sur ce mur de béton, ou vous pouvez coller les instructions de Shadowsocks et quelques codes QR à la place!
  * [AEAD](https://shadowsocks.org/fr/spec/AEAD-Ciphers.html) est activé avec ChaCha20 et Poly1305 pour un contournement plus efficace du GFW.
  * Le plugin [simple-obfs](https://github.com/shadowsocks/simple-obfs) est installé afin de fournir une techique d'évasion du votre trafic sur des réseaux hostiles (en particulier ceux qui appliquent la limitation de la qualité de service (QOS)).
* [sslh](http://www.rutschle.net/tech/sslh.shtml)
  * Sslh est un démultiplexeur de protocole qui permet à Nginx, OpenSSH et OpenVPN de partager le port 443. Cela fournit une autre option de connexion et signifie que vous pouvez toujours acheminer le trafic via OpenSSH et OpenVPN même si vous êtes sur un réseau restrictif qui bloque tout accès à des ports non HTTP.
* [Stunnel](https://www.stunnel.org/index.html)
  * Écoute et enveloppe les connexions OpenVPN. Cela les fait ressembler au trafic SSL standard et permet aux clients OpenVPN d'établir avec succès des tunnels même en présence d'une inspection approfondie des paquets.
  * Des profils unifiés pour les connexions OpenVPN enveloppées de stunnel sont générés à côté des profils de connexion directe. Des instructions détaillées sont également générées.
  * Le certificat stunnel et la clé sont exportés au format PKCS # 12 afin qu'ils soient compatibles avec d'autres applications de tunneling SSL. Notamment, cela permet à [OpenVPN pour Androïde](https://play.google.com/store/apps/details?id=de.blinkt.openvpn&hl=fr) de tunneliser son trafic via [SSLDroid](https://play.google .com / store / apps / details? Id = hu.blint.ssldroid). OpenVPN en Chine sur un appareil mobile? Oui!
* [Tor](https://www.torproject.org/)
  * Un [pont relais](https://www.torproject.org/docs/bridges) est mis en place avec un surnom aléatoire.
  * [Obfsproxy](https://www.torproject.org/projects/obfsproxy.html.en) est installé et configuré avec le support pour le transport enfichable obfs4.
  * Un code BridgeQR est généré et peut être utilisé pour configurer automatiquement [Orbot](https://play.google.com/store/apps/details?id=org.torproject.android&hl=fr) pour Androïde.
* [UFW](https://wiki.ubuntu.com/UncomplicatedFirewall)
  * Les règles de pare-feu sont configurées pour chaque service et tout trafic qui est envoyé vers un port non autorisé sera bloqué.
* [unattended-upgrades](https://help.ubuntu.com/community/AutomaticSecurityUpdates)
  * Votre serveur Streisand est configuré pour installer automatiquement de nouvelles mises à jour de sécurité.
* [WireGuard](https://www.wireguard.com/)
  * Les utilisateurs Linux peuvent profiter d'un VPN de nouvelle génération qui est simple mais à la même fois moderne, basé dans le noyau, et utilise des principes cryptographiques modernes que toutes les autres solutions VPN ne fournissent pas.
