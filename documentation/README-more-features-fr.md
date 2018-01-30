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

Nouvelles fonctionnalités à venir
---------------------------------
* Configuration simplifiée.
