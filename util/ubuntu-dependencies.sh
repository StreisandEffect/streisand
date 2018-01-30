#!/bin/bash

# Abort on any error.
set -e

# This script installs Streisand builder dependencies on an Ubuntu
# 16.04 system; Debian jessie has been lightly tested. It installs
# system-wide packages. As a result, this is most useful on a fresh
# machine, where conflicting Python packages won't be installed. If
# you're not on a fresh regular machine, consider using
# venv-dependencies.sh instead.
#
# It's safe to run this script multiple times. For most cloud
# providers, it should work as a boot/cloud-init script.
#
# The defaults are fine for an interactive install. If you are using
# this as a cloud-init script, change the first two settings:
#
#  *  quiet must be "--yes"
#  *  The "DEBIAN_FRONTEND" line must be uncommented.

# We default to a regular, interactive upgrade.
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

# Prefer binaries distributed by upstream OS over those in the pip
# repository.

# We explicitly want word splitting.
# shellcheck disable=SC2046
sudo apt-get $quiet install $(cat ./util/dependencies.txt)

# Debian doesn't have python-nacl. We'll have to accept the pip
# version.
if ! sudo apt-get $quiet install python-nacl libssl-dev; then
    our_pip_install pynacl
fi

# We only really wanted python-pip for its dependencies. Upgrade it.
our_pip_install pip

# The pip we want should be in our path now. Make sure we use it.
hash -r

# We explicitly want word splitting.
# shellcheck disable=SC2059,SC2086
our_pip_install -r requirements.txt

echo '
Streisand dependencies installed.
'
