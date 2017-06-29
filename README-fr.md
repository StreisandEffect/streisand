![Streisand Logo](https://raw.githubusercontent.com/jlund/streisand/master/logo.jpg "Automate the effect")

- - -
[English](README.md), [Français](README-fr.md)
- - -

Streisand
=========

**Silence la censure. Automatiser [l'effet](https://fr.wikipedia.org/wiki/Effet_Streisand).**

L'Internet peut être un peu injuste. Il est trop facile pour les fournisseurs de services Internet, les télécoms, les politiciens et les entreprises de bloquer l'accès aux sites et aux informations qui vous intéressent. Mais briser ces restrictions est *difficile*. Ou est-ce?

Présentation de Streisand
-------------------------
* Une seule commande configure un tout nouveau serveur Ubuntu 16.04 exécutant une [grande variété de logiciels anti-censure](#services-provided) qui peuvent masquer et chiffrer totalement votre trafic Internet.
* Streisand supporte nativement la création de nouveaux serveurs chez [Amazon EC2](https://aws.amazon.com/ec2/), [Azure](https://azure.microsoft.com/fr-fr/), [DigitalOcean](https://www.digitalocean.com/), [Google Compute Engine](Https://cloud.google.com/compute/), [Linode](https://www.linode.com/) et [Rackspace](https://www.rackspace.com/)&mdash; et plus de fournisseurs à venir! Il fonctionne également sur n'importe quel serveur Ubuntu 16.04 quel que soit le fournisseur, et des **centaines** d'instances peuvent être configurés simultanément en utilisant cette méthode.
* Le processus est entièrement automatisé et ne prend que quelques dizaines de minutes, ce qui est assez remarquable si vous considérez qu'il faudrait un administrateur système au moins plusieurs jours de contrainte pour mettre en place un petit sous-ensemble de ce que Streisand offre dans sa configuration.
* Une fois que votre serveur Streisand est en cours d'exécution, vous pouvez donner les instructions de connexion personnalisée à vos amis, membres de la famille et activistes. Les instructions de connexion contiennent une copie intégrée du certificat SSL unique du serveur, il vous suffit de leur envoyer un seul fichier.
* Chaque serveur est entièrement autonome et comprend tout ce dont les utilisateurs ont besoin pour démarrer, y compris les miroirs cryptographiquement vérifiés de tous les clients communs. Cela rend toute tentative de censure des emplacements de téléchargement par défaut complètement inefficace.
* Mais attendez, il y a plus..

Plus de fonctionnalités
-----------------------
* Nginx alimente la passerelle protégée par mot de passe et cryptée qui sert de point de départ pour les nouveaux utilisateurs. La passerelle est accessible via SSL, ou comme [service caché](https://www.torproject.org/docs/hidden-services.html.en) Tor.
  * Instructions belles, personnalisées, et étape par étape, les configurations du client sont générées pour chaque nouveau serveur que Streisand crée. Les utilisateurs peuvent accéder rapidement à ces instructions via n'importe quel navigateur Web. Les instructions sont réactives et fantastiques sur les téléphones mobiles.
  * L'intégrité du logiciel mis en miroir est assurée en utilisant les sommes de contrôle SHA-256 ou en vérifiant les signatures GPG si le projet les fournit. Cela protège les utilisateurs contre le téléchargement de fichiers corrompus.
  * Tous les fichiers auxiliaires, tels que les profils de configuration OpenVPN, sont également disponibles via la passerelle.
  * Les utilisateurs actuels de Tor peuvent profiter des services supplémentaires que Streisand met en place pour transférer des fichiers volumineux ou pour traiter d'autres types de trafic (par exemple BitTorrent) qui ne sont pas appropriés pour le réseau Tor.
  * Un mot de passe unique, un certificat SSL et une clé privée SSL sont générés pour chaque passerelle Streisand. Les instructions de la passerelle et le certificat sont transférés via SSH à la fin de l'exécution de Streisand.
* Des services distincts et des daemons multiples offrent une énorme flexibilité. Si une méthode de connexion est bloquée, il existe de nombreuses options disponibles, dont la plupart sont résistantes à l'inspection des paquets en profondeur.
  * Toutes les méthodes de connexion (y compris L2TP/IPsec et connexions directes OpenVPN) sont efficaces contre le type de blocage avec lequel la Turquie a expérimenté.
  * OpenConnect/AnyConnect, OpenSSH, OpenVPN (enveloppé dans stunnel), Shadowsocks et Tor (avec obfsproxy et obfs4 transports enfichables) sont tous actuellement efficace contre le grand pare-feu de la Chine.
* Chaque tâche a été bien documentée et a donné une description détaillée. Streisand est simultanément le HOWTO le plus complet en existance pour l'installation de tous les logiciels qu'il installe, et aussi l'antidote pour avoir à faire jamais tout cela à la main de nouveau.
* Tous les logiciels fonctionnent sur des ports qui ont été délibérément choisis pour rendre le blocage de ports simpliste irréaliste sans causer de dommages collatéraux massifs. OpenVPN, par exemple, ne fonctionne pas sur le port défaut de 1194, mais utilise le port standard 636 pour les connexions LDAP/SSL qui sont aimés par des entreprises du monde entier.
  * *L2TP/IPsec est une exception notable à cette règle car les ports ne peuvent pas être modifiés sans rompre la compatibilité du client*

<a name="services-provided"></a>
Services fournis
----------------
* L2TP/IPsec en utilisant [Libreswan](https://libreswan.org/) et [xl2tpd](https://www.xelerance.com/software/xl2tpd/)
  * Une clé et un mot de passe pré-partagés choisis au hasard sont générés.
  * Les utilisateurs Windows, OS X, Androïde et iOS peuvent tous se connecter en utilisant le support VPN natif intégré à chaque système d'exploitation sans installer de logiciel supplémentaire.
* [Monit](https://mmonit.com/monit/)
  * Surveille la santé du processus et redémarre automatiquement les services dans le cas improbable où ils se plante ou ne répondent pas.
* [OpenSSH](http://www.openssh.com/)
  * Un utilisateur de transfert non privilégié et une paire paire de clés asymétriques SSH sont générés pour les fonctionnalités [sshuttle](https://github.com/sshuttle/sshuttle) et SOCKS.
  * Les tunnels Windows et Androïde SSH sont également pris en charge et une copie des clés sont exportée dans le format .ppk que PuTTY requiert.
  * [Tinyproxy](https://banu.com/tinyproxy/) est installé et lié à localhost. Il peut être accédé sur un tunnel SSH par des programmes qui ne prennent pas en charge nativement SOCKS et qui nécessitent un proxy HTTP, comme Twitter pour Androïde.
* [OpenConnect](http://www.infradead.org/ocserv/index.html)/[Cisco AnyConnect](http://www.cisco.com/c/en/us/products/security/anyconnect-secure-mobility-client/index.html)
  * OpenConnect (ocserv) est un serveur VPN extrêmement performant et léger qui offre également une compatibilité totale avec les clients officiels Cisco AnyConnect.
  * Le [protocole](http://www.infradead.org/ocserv/technical.html) est bâti sur des standards comme HTTP, TLS et DTLS, et c'est l'une des technologies VPN les plus populaires et largement utilisées parmi des grands entreprises multi-nationales.
    * Cela signifie qu'en plus de sa facilité d'utilisation et de sa rapidité, OpenConnect est également très résistant à la censure et presque jamais bloqué.
* [OpenVPN](https://openvpn.net/index.php/open-source.html)
  * Des profils autonome "unifiés" .ovpn sont générés pour une configuration de client facile en utilisant un seul fichier.
  * Les connexions TCP et UDP sont prises en charge.
  * Plusieurs clients peuvent facilement partager les mêmes certificats et clés, mais cinq ensembles distincts sont générés par défaut.
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
* [WireGuard](https://www.wireguard.io/)
  * Les utilisateurs Linux peuvent profiter d'un VPN de nouvelle génération qui est simple mais à la même fois moderne, basé dans le noyau, et utilise des principes cryptographiques modernes que toutes les autres solutions VPN ne fournissent pas.

Installation
------------
Veuillez lire *attentivement* toutes les instructions d'installation avant de poursuivre.

### Clarification importante ###
Streisand est basé sur [Ansible](http://www.ansible.com/home), un outil d'automatisation qui est généralement utilisé pour fournir et configurer des fichiers et des paquets sur des serveurs distants. Cela signifie que lorsque vous exécutez Streisand, il configure automatiquement **un autre serveur distant** avec les paquets VPN et ses configurations.

Streisand va déployer **un autre serveur** sur votre fournisseur d'hébergement choisi lorsque vous exécutez **sur votre ordinateur local** (par exemple, votre ordinateur portable). Habituellement, vous **n'utilisez pas Streisand sur le serveur distant** car, par défaut, cela entraînerait le déploiement d'un autre serveur à partir de votre serveur et rendrait le premier serveur redondant (Ouf!).

Dans certains cas, les utilisateurs avancés peuvent opter pour le mode de provisionnement local pour que le système fonctionne avec Streisand/Ansible se configure comme un serveur Streisand. Il s'agit d'un mode de configuration mieux réservé quand ce n'est pas possible d'installer Ansible sur votre ordinateur local ou lorsque votre connexion à un fournisseur de cloud est peu fiable pour les connexions SSH requis par Ansible.

### Prérequis ###
Effectuez toutes ces tâches sur votre machine locale.

* Streisand nécessite un système BSD, Linux ou OS X. À partir de maintenant, Windows n'est pas soutenu. Toutes les commandes suivantes doivent être exécutées à l'intérieur d'une session Terminal.
* Python 2.7 est nécessaire. Cela est standard sur OS X, et est la valeur par défaut sur presque toutes les distributions Linux et BSD. Si votre distribution emploie Python 3 à la place, vous devrez installer la version 2.7 pour que Streisand fonctionne correctement.
* Assurez-vous qu'une clé SSH est présente dans ~/.ssh/id\_rsa.pub.
  * Si vous n'avez pas de clé SSH, vous pouvez en générer une en utilisant cette commande et en suivant les valeurs par défaut:

            ssh-keygen
* Installez Git.
  * Sur Debian et Ubuntu

            sudo apt-get install git
  * Sur Fedora

            sudo yum install git
  * Sur OS X (via [Homebrew](http://brew.sh/))

            brew install git
* Installez le système de gestion de paquets [pip](https://pip.pypa.io/en/latest/) pour Python.
  * Sur Debian et Ubuntu (installe également les dépendances qui sont nécessaires pour construire Ansible et qui sont requises par certains modules)

            sudo apt-get install python-paramiko python-pip python-pycurl python-dev build-essential
  * Sur Fedora

            sudo yum install python-pip
  * Sur OS X

            sudo easy_install pip
            sudo pip install pycurl

* Installez [Ansible](http://www.ansible.com/home).
  * Sur OS X (via [Homebrew](http://brew.sh/))

            brew install ansible
  * Sur BSD ou Linux (via pip)

            sudo pip install ansible markupsafe
* Installez les bibliothèques Python nécessaires pour votre fournisseur de cloud.
  * Amazon EC2

            sudo pip install boto
  * Azure

            sudo pip install msrest msrestazure azure==2.0.0rc5
  * DigitalOcean

            sudo pip install dopy==0.3.5
  * Google

            sudo pip install "apache-libcloud>=0.17.0"
  * Linode

            sudo pip install linode-python
  * Rackspace Cloud

            sudo pip install pyrax
  * Si vous utilisez une version de Python installée avec Homebrew, vous devez également exécuter ces commandes pour vous assurer qu'il peut trouver les bibliothèques nécessaires:

            mkdir -p ~/Library/Python/2.7/lib/python/site-packages
            echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth

### Exécution ###
1. Clonez le répertoire Streisand et entrez dans le répertoire.

        git clone https://github.com/jlund/streisand.git && cd streisand
2. Exécuter le script Streisand.

        ./streisand
3. Suivez les instructions pour choisir votre fournisseur, la région physique du serveur, et son nom. Vous serez également invité à entrer les informations de l'API.
4. Une fois les informations de connexion et les clés d'API saisies, Streisand commencera à faire tourner un nouveau serveur distant.
5. Attendez que l'installation soit terminée (cela prend habituellement environ dix minutes) et recherchez les fichiers correspondants dans le dossier 'generated-docs' dans le répertoire du dépôt Streisand. Le fichier HTML expliquera comment se connecter à la passerelle via SSL ou via le service caché Tor. Toutes les instructions, les fichiers, les clients en miroir et les clés du nouveau serveur se trouvent alors sur la passerelle. Vous avez fini!

### Installation de Streisand sur localhost (Avancé) ###

Si vous ne pouvez pas exécuter Streisand de la manière normale (à partir de votre ordinateur client/ordinateur portable pour configurer un serveur distant), Streisand prend en charge un mode de provisionnement local. Choisissez simplement "Localhost (Advanced)" dans le menu après avoir exécuté `./streisand`.

**Note:** L'installation de Streisand sur localhost peut être une action destructive! Vous pourriez potentiellement écraser des fichiers de configuration; vous devez être certain que vous affectez la machine correcte.

### Exécution de Streisand sur d'autres fournisseurs (Avancé) ###

Vous pouvez également exécuter Streisand sur un nouveau serveur Ubuntu 16.04. Serveur dédié? Génial! Fournisseur de cloud ésotérique? Fantastique! Pour ce faire, choisissez simplement `Existing server (Advanced)` dans le menu après avoir exécuté `./streisand` et fournissez l'adresse IP du serveur existant lorsque vous y êtes invité.

Le serveur doit être accessible en utilisant la clé SSH `$HOME/id_rsa`, avec **root** comme utilisateur de connexion par défaut. Si votre fournisseur vous demande un utilisateur SSH au lieu de `root` (par exemple, `ubuntu`), spécifiez la variable environnementale `ANSIBLE_SSH_USER` (par exemple `ANSIBLE_SSH_USER=ubuntu`) lorsque vous exécutez `./streisand`.

**Note:** L'installation de Streisand sur localhost peut être une action destructive! Vous pourriez potentiellement écraser des fichiers de configuration; vous devez être certain que vous affectez la machine correcte.

Nouvelles fonctionnalités à venir
---------------------------------
* Sélection et isolement des rôles, vous permettant de choisir quels services sont installés.
* Configuration simplifiée.

S'il ya quelque chose que vous pensez que Streisand devrait faire, ou si vous trouviez un bug dans sa documentation ou son exécution, s'il vous plaît déposer un rapport sur le [Issue Tracker](https://github.com/jlund/streisand/issues).

Remerciements
-------------
[Jason A. Donenfeld](https://www.zx2c4.com/) mérite beaucoup de crédit pour être assez courageux à réimaginer ce qu'est un VPN moderne devrait ressembler et pour mettre au monde quelque chose aussi épatant que [WireGuard](https://www.wireguard.io/). Il a mes sincères remerciements pour toute son aide, patience et ses commentaires.

[Corban Raun](https://github.com/CorbanR) à eu la gentillesse de me prêter un ordinateur portable Windows qui m'a permi de tester et d'affiner les instructions pour cette plate-forme, aussi bien qu'il était un grand partisan du projet dès le début.

Je ne peux pas exprimer à quel point je suis reconnaissant à [Trevor Smith](https://github.com/trevorsmith) pour ses contributions massives au projet. Il a suggéré l'approche passerelle, fourni des tonnes de commentaires inestimable, a fait *tout* pour apparaître mieux, et développé le modèle HTML qui a servi d'inspiration pour faire passer les choses au niveau suivant avant la diffusion publique de Streisand. J'ai également apprécié l'utilisation fréquente de son iPhone tout en testant des clients divers.

Un grand merci à [Paul Wouters](https://nohats.ca/) de [The Libreswan Projet](https://libreswan.org/) à son aide généreuse pour le débogage des configurations d'L2TP/IPsec.

En travaillant sur Streisand, j'ai écouté l'album 'Sunset Blood' de [Starcadian](http://starcadian.com/) environ 300 fois en répétition.
