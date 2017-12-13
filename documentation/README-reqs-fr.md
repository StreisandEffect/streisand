### Prérequis ###
Effectuez toutes ces tâches sur votre machine locale.

* Streisand nécessite un système BSD, Linux ou macOS. À partir de maintenant, Windows n'est pas soutenu. Toutes les commandes suivantes doivent être exécutées à l'intérieur d'une session Terminal.
* Python 2.7 est nécessaire. Cela est standard sur macOS, et est la valeur par défaut sur presque toutes les distributions Linux et BSD. Si votre distribution emploie Python 3 à la place, vous devrez installer la version 2.7 pour que Streisand fonctionne correctement.
* Assurez-vous qu'une clé SSH est présente dans ~/.ssh/id\_rsa.pub.
  * Si vous n'avez pas de clé SSH, vous pouvez en générer une en utilisant cette commande et en suivant les valeurs par défaut:

            ssh-keygen
* Installez Git.
  * Sur Debian et Ubuntu

            sudo apt-get install git
  * Sur Fedora

            sudo yum install git
  * Sur macOS (via [Homebrew](http://brew.sh/))

            brew install git
* Installez le système de gestion de paquets [pip](https://pip.pypa.io/en/latest/) pour Python.
  * Sur Debian et Ubuntu (installe également les dépendances qui sont nécessaires pour construire Ansible et qui sont requises par certains modules)

            sudo apt-get install python-paramiko python-pip python-pycurl python-dev build-essential
  * Sur Fedora

            sudo yum install python-pip
  * Sur macOS

            sudo easy_install pip
            sudo pip install pycurl

* Installez [Ansible](http://www.ansible.com/home).
  * Sur macOS (via [Homebrew](http://brew.sh/))

            brew install ansible
  * Sur BSD ou Linux (via pip)

            sudo pip install ansible markupsafe
* Installez les bibliothèques Python nécessaires pour votre fournisseur de cloud.
  * Amazon EC2

            sudo pip install boto
  * Azure

            sudo pip install ansible[azure]
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

