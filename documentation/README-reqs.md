### Prerequisites ###
Complete all of these tasks on your local home machine.

* Streisand requires a BSD, Linux, or macOS system. As of now, Windows is not supported. All of the following commands should be run inside a Terminal session.
* Python 2.7 is required. This comes standard on macOS, and is the default on almost all Linux and BSD distributions as well. If your distribution packages Python 3 instead, you will need to install version 2.7 in order for Streisand to work properly.
* Make sure an SSH key is present in ~/.ssh/id\_rsa.pub.
  * If you do not have an SSH key, you can generate one by using this command and following the defaults:

        ssh-keygen
* Install Git.
  * On Debian and Ubuntu

        sudo apt-get install git
  * On Fedora

        sudo yum install git
  * On macOS (via [Homebrew](http://brew.sh/))

        brew install git
* Install the [pip](https://pip.pypa.io/en/latest/) package management system for Python.
  * On Debian and Ubuntu (also installs the dependencies that are necessary to build Ansible and that are required by some modules)

        sudo apt-get install python-paramiko python-pip python-pycurl python-dev build-essential
  * On Fedora

        sudo yum install python-pip
  * On macOS

        sudo easy_install pip
        sudo pip install pycurl

* Install [Ansible](http://www.ansible.com/home).
  * On macOS (via [Homebrew](http://brew.sh/))

        brew install ansible
  * On BSD or Linux (via pip)

        sudo pip install ansible markupsafe
* Install the necessary Python libraries for your chosen cloud provider. If you
    are using the advanced local provisioning mode or the existing server mode
    you can skip this section.
  * Amazon EC2

        sudo pip install boto
  * Azure

        sudo pip install ansible[azure]
  * DigitalOcean

        sudo pip install dopy==0.3.5
  * Google

        sudo pip install "apache-libcloud>=1.5.0"

  * Linode

        sudo pip install linode-python
  * Rackspace Cloud

        sudo pip install pyrax
  * **Important note if you are using a Homebrew-installed version of Python** you should also run these commands to make sure it can find the necessary libraries:

        mkdir -p ~/Library/Python/2.7/lib/python/site-packages
        echo '/usr/local/lib/python2.7/site-packages' > ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth
