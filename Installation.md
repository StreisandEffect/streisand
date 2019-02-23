# Installation
------------
Please read all installation instructions **carefully** before proceeding.

If you're an expert, and installing on a cloud provider Streisand doesn't support, make sure to read [the advanced installation instructions](Advanced%20installation.md).

### Important Clarification ###
Streisand is based on [Ansible](https://www.ansible.com/), an automation tool that is typically used to provision and configure files and packages on remote servers. Streisand automatically sets up **another server** with the VPN packages and configuration. We call the machine that sets up the Streisand server the *builder*. Think of the builder as "a place to stand."

(If you don't have a suitable builder machine, you could set up another cloud server to use as your builder. That means you'd have two cloud servers at the end — the builder, and your fresh new Streisand *server*.  After downloading the *builder's* `streisand` directory — very important to keep the contents of that directory! — you could delete the builder cloud server.)

Although it's not recommended, sometimes you can use a fresh server as both the builder and the server. See the [the advanced installation instructions](Advanced%20installation.md).

### Prerequisites ###
Complete all of these tasks on your local home machine.

* Streisand requires a BSD, Linux, or macOS system. As of now, Windows is not supported, although the Windows Subsystem For Linux (WSL) should work. All of the following commands should be run inside a command-line session.
* Python 2.7 is required. This comes standard on macOS, and is the default on almost all Linux and BSD distributions as well. If your distribution packages Python 3 instead, you will need to install version 2.7 in order for Streisand to work properly.
* Make sure an SSH public key is present in ~/.ssh/id\_rsa.pub.
  * SSH keys are a more secure alternative to passwords that allow you to prove your identity to a server or service built on public key cryptography. The public key is something that you can give to others, whereas the private key should be kept secret (like a password).
  * To check if you already have an SSH public key, please enter the following command at a command prompt.
  
        ls ~/.ssh
  * If you see an id_rsa.pub file, then you have an SSH public key.
  * If you do not have an SSH key pair, you can generate one by using this command and following the defaults:

        ssh-keygen
  * If you'd like to use an SSH key with a different name or in a non-standard location, please enter 'yes' when asked if you'd like to customize your instance during installation.
  * **Please note**: You will need these keys to access your Streisand instance over SSH. Please keep them for the lifetime of the Streisand server.
### Bootstrap ###
* Install the bootstrap packages: Git, and `pip` for Python 2.7.

  * On Debian and Ubuntu

        sudo apt-get install git python-pip
  * On Fedora 27, some additional packages are needed later.

		sudo dnf install git python2-pip gcc python2-devel python2-crypto python2-pycurl libcurl-devel
  * On CentOS 7, `pip` is available from the EPEL repository; some additional packages are needed later.

		sudo yum -y update && sudo yum install -y epel-release
		sudo yum -y update && sudo yum install -y git gcc python-devel python-crypto python-pycurl python-pip libcurl-devel
  * On macOS, `git` is part of the Developer Tools, and it will be installed the first time you run it. If there isn't already a `pip` command installed, install it with:

        sudo python2.7 -m ensurepip

### Execution ###
1. Clone the Streisand repository and enter the directory.

        git clone https://github.com/StreisandEffect/streisand.git && cd streisand

2. Run the installer for Ansible and its dependencies.

        ./util/venv-dependencies.sh ./venv
  * The installer will detect missing packages, and print the commands needed to install them.

3. Activate the Ansible packages that were installed.

        source ./venv/bin/activate

4. Execute the Streisand script.

        ./streisand
5. Follow the prompts to choose your provider, the physical region for the server, and its name. You will also be asked to enter API information.
5. Once login information and API keys are entered, Streisand will begin spinning up a new remote server.
6. Wait for the setup to complete (this usually takes around ten minutes) and look for the corresponding files in the 'generated-docs' folder in the Streisand repository directory. The HTML file will explain how to connect to the Gateway over SSL, or via the Tor hidden service. All instructions, files, mirrored clients, and keys for the new server can then be found on the Gateway. You are all done!
