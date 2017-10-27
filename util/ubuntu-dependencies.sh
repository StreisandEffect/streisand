#!/bin/bash

# Abort on any error.
set -e

# This script installs Streisand builder dependencies on an Ubuntu
# 16.04 system; Debian jessie has been lightly tested. It installs
# system-wide packages.
#
# It's safe to run this script multiple times.

# We default to a regular, interactive upgrade:
quiet=
# quiet='--yes'

# If you *really* want no interaction (for example, overwriting local
# config files without prompting), then uncomment this:
# export DEBIAN_FRONTEND=noninteractive

# If you'd prefer to install dependencies in ~/.local/bin, uncomment
# this function and comment the next.

#function our_pip_install () {
#    pip install --user --upgrade "$@"
#}

function our_pip_install () {
    sudo -H pip install --upgrade "$@"
}

### No options below this line. ###

sudo apt-get update
sudo apt-get $quiet upgrade

# We explicitly want word splitting.
# shellcheck disable=SC2046
sudo apt-get $quiet install $(cat <<EOF
build-essential
python-dev
python-setuptools
python-pip
python-cffi libffi-dev
EOF
)

# Debian doesn't have python-nacl.
if ! sudo apt-get $quiet install python-nacl libssl-dev; then
    our_pip_install pynacl
fi

# We only really wanted python-pip for its dependencies. Upgrade it.
our_pip_install pip

# The pip we want should be in our path now. Make sure we use it.
hash -r

our_pip_install ansible

# Python dependencies for various providers. Note that
# "ansible[azure]" means "install ansible, and add additional
# dependencies packages from ansible's 'azure' set. Since ansible is
# already installed (see above), this just means "Azure dependencies".

packages="$(cat <<EOF
boto boto3
ansible[azure]
dopy==0.3.5
apache-libcloud>=1.5.0
linode-python
pyrax
EOF
)"

# We explicitly want word splitting.
# shellcheck disable=SC2059,SC2086
our_pip_install $packages

echo '
Streisand dependencies installed.
'
