Installation
------------
Veuillez lire *attentivement* toutes les instructions d'installation avant de poursuivre.

### Clarification importante ###
Streisand est basé sur [Ansible](http://www.ansible.com/home), un outil d'automatisation qui est généralement utilisé pour fournir et configurer des fichiers et des paquets sur des serveurs distants. Cela signifie que lorsque vous exécutez Streisand, il configure automatiquement **un autre serveur distant** avec les paquets VPN et ses configurations.

Streisand va déployer **un autre serveur** sur votre fournisseur d'hébergement choisi lorsque vous exécutez **sur votre ordinateur local** (par exemple, votre ordinateur portable). Habituellement, vous **n'utilisez pas Streisand sur le serveur distant** car, par défaut, cela entraînerait le déploiement d'un autre serveur à partir de votre serveur et rendrait le premier serveur redondant (Ouf!).

Dans certains cas, les utilisateurs avancés peuvent opter pour le mode de provisionnement local pour que le système fonctionne avec Streisand/Ansible se configure comme un serveur Streisand. Il s'agit d'un mode de configuration mieux réservé quand ce n'est pas possible d'installer Ansible sur votre ordinateur local ou lorsque votre connexion à un fournisseur de cloud est peu fiable pour les connexions SSH requis par Ansible.

### Exécution ###
1. Clonez le répertoire Streisand et entrez dans le répertoire.

        git clone https://github.com/StreisandEffect/streisand.git && cd streisand
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

### Déploiement non interactif (Avancé) ###

Des scripts alternatifs et des exemples de fichiers de configuration sont fournis pour les déploiements non interactifs, dans lequel toutes les informations requises sont transmises sur la ligne de commande ou dans un fichier de configuration.

Des exemples de fichiers de configuration se trouvent sous `global_vars/noninteractive`. Copiez et modifiez les paramètres souhaités, tels que la fourniture de jetons d'API et d'autres choix, puis exécutez le script.

Pour déployer un nouveau serveur Streisand:

      deploy/streisand-new-cloud-server.sh \
        --provider digitalocean \
        --site-config global_vars/noninteractive/digitalocean-site.yml

Pour exécuter l'approvisionnement Streisand sur la machine locale:

      deploy/streisand-local.sh \
        --site-config global_vars/noninteractive/local-site.yml

Pour exécuter l'approvisionnement Streisand contre un serveur existant:

      deploy/streisand-existing-cloud-server.sh \
        --ip-address 10.10.10.10 \
        --ssh-user root \
        --site-config global_vars/noninteractive/digitalocean-site.yml
