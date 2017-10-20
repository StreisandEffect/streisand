#!/bin/bash
set -e

# This script installs Streisand builder dependencies on an Ubuntu
# 16.04 system; Debian jessie has been lightly tested. It installs
# system packages for binary dependencies, and installs the rest in
# the python directories in $HOME/.local.

# We default to a regular, interactive upgrade:
quiet=
# quiet='--yes'

# It's safe to run this script multiple times.



# If you *really* want no interaction (for example, overwriting local
# config files without prompting), then uncomment this:
# export DEBIAN_FRONTEND=noninteractive

### No options below this line. ###

set -e
set -x

function our_pip_install () {
    pip install --user --upgrade "$@"
}

# Hopefully, the blank lines following these statements will answer "yes" if
# somebody's pasting.

sudo apt-get update

sudo apt-get $quiet upgrade



# We want word splitting.
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

# Ansible 2.4 breaks CI currently.
our_pip_install "ansible<2.4"

# In case somebody really is pasting these lines into an interactive shell,
# make sure our ansible is found.
hash -r

packages=$(cat <<EOF
boto boto3
msrest msrestazure azure==2.0.0rc5 packaging
dopy==0.3.5
apache-libcloud>=1.5.0
linode-python
pyrax
EOF
)

# We want word splitting.
# shellcheck disable=SC2059,SC2086
our_pip_install $packages

echo 'Streisand dependencies installed.'
