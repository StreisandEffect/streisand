# Installation

Please read all installation instructions **carefully** before proceeding.

If you're an expert, and installing on a cloud provider Streisand doesn't support, make sure to read [the advanced installation instructions](Advanced%20installation.md).

## Important: definitions ##
Streisand is based on [Ansible](https://www.ansible.com/), an automation tool that is typically used to provision and configure files and packages on remote servers. Streisand automatically sets up **another server** with the VPN packages and configuration. We call the machine that sets up the Streisand server the *builder*. Think of the builder as "a place to stand."

* If you don't have a suitable builder machine, you could set up another cloud server to use as your builder. That means you'd have two cloud servers at the end — the builder, and your fresh new Streisand *server*.  When you're done with the builder, make sure you download the *builder's* `streisand` directory — very important to keep the contents of that directory! — you could delete the *builder* cloud server.)

* Although it's not recommended, sometimes you can use a fresh server as both the builder and the server. See the [the advanced installation instructions](Advanced%20installation.md).

## Prerequisites ##

The Streisand builder requires a Linux, macOS, or BSD system.

* Using native Windows as a builder is not supported, but Ubuntu on the [Windows Subsystem For Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/faq) should work. ([Ubuntu install link on Microsoft Store](https://www.microsoft.com/en-us/p/ubuntu-1804-lts/9n9tngvndl3q))

Complete all of these tasks on your local machine. All of the commands should be run inside a command-line session.

### SSH key

Make sure an SSH public key is present in `~/.ssh/id_rsa.pub`.

  * SSH keys are a more secure alternative to passwords that allow you to prove your identity to a server or service built on public key cryptography. The public key is something that you can give to others, whereas the private key should be kept secret (like a password).

To check if you already have an SSH public key, enter the following command at a command prompt:

```
ls ~/.ssh
```

If you see an `id_rsa.pub` file, then you have an SSH public key. If you do not have an SSH key pair, you can generate one by using this command and following the defaults:

```
ssh-keygen
```

If you'd like to use an SSH key with a different name or from a non-standard location, please enter *yes* when asked if you'd like to customize your instance during installation.

  * **Please note**: You will need these keys to access your Streisand instance over SSH. Please keep `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub` for the lifetime of the Streisand server.


## Bootstrap ##

Install the bootstrap packages: Git, and Python 3.5 or later. Some environments need additional packages.

Here's how to set up these packages:

* On Debian and Ubuntu:

```
sudo apt-get install git python3 python3-venv
```

* On Fedora 30, some additional packages are needed later:

```
dnf install git python3 gcc python3-devel python3-crypto \
     python3-pycurl libcurl-devel

```

* On CentOS 7, `python36` is available from the EPEL repository; some additional packages are needed later:

```
sudo yum -y update && sudo yum install -y epel-release
sudo yum -y update && sudo yum install -y \
    git gcc python36-devel python36-crypto python36-pycurl \
    libcurl-devel
```

* On macOS, `git` is part of the Developer Tools, and it will be installed the first time you run it. Python 3.5 or later is required. Either use [Homebrew](https://brew.sh/) and run `brew install python3`, or see [the Python.org Mac download site](https://www.python.org/downloads/mac-osx/); the package you want to download is the "macOS 64-bit installer".

## Execution ##

1. Clone the Streisand repository and enter the directory.

        git clone https://github.com/StreisandEffect/streisand.git && cd streisand

1. Run the installer for Ansible and its dependencies. The installer will detect missing packages, and print the commands needed to install them. (Ignore the Python 2.7 `DEPRECATION` warning; ignore the warning from python-novaclient that pbr 5.1.3 is incompatible.)

       ./util/venv-dependencies.sh ./venv

1. Activate the Ansible packages that were installed.

        source ./venv/bin/activate

1. Execute the Streisand script.

        ./streisand

1. Follow the prompts to choose your provider, the physical region for the server, and its name. You will also be asked to enter API information.
1. Once login information and API keys are entered, Streisand will begin spinning up a new remote server.
1. Wait for the setup to complete (this usually takes around ten minutes) and look for the corresponding files in the `generated-docs` folder in the Streisand repository directory. The HTML file will explain how to connect to the Gateway over SSL, or via the Tor hidden service. All instructions, files, mirrored clients, and keys for the new server can then be found on the Gateway. You are all done!

## Keep the results!

You should keep a copy of the `generated-docs` directory for the life of the server.

Remember to save your `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub` SSH keys too. You'll need them in case you want to troubleshoot or perform maintenance on your server later.
