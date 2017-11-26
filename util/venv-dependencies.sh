#!/bin/bash

# Abort on any error.
set -e

# Usage: util/venv-dependencies.sh NEW-DIRECTORY
#
# See the usage function below.

quiet=
# pip makes a lot of noise when installing. Uncomment the following
# line to make it a little quieter.
# quiet=--quiet

#### Options end here.

usage () {
       echo "
Usage: $0 new-directory

This script installs Streisand builder dependencies into an isolated
Python virtualenv. A virtualenv is one of the most reliable ways of
avoiding version clashes, and is especially recommended for people
having problems with initial Streisand installs.

Note that this script is not guaranteed to work for localhost
deployments. This will be fixed in a later release.

It depends on Python 2.7, and on a pip command functional enough to
install virtualenv.  If this is a system running Debian or Ubuntu,
this script will also check for other packages needed to install.

This script can install virtualenv for you, but on Linux, this
requires sudo/root access.

'new-directory' must be somewhere you can write to. A good place may be
$HOME/streisand-deps. 
"
}

is_root=""
if [ "$(id -u)" == "0" ]; then
    is_root=1
fi

sudo_command="sudo"
sudo_for_pip_install="sudo -H"

# If we're root, get rid of sudo--it may not be there...
if [ -n "$is_root" ]; then
    sudo_command=""
    sudo_for_pip_install=""
fi

invocation_problems=
if [ "$#" -ne 1 ]; then
   usage
   invocation_problems=1
fi

if ! pip >/dev/null 2>&1; then
   echo "
You need a working 'pip' command. To get one:

On Ubuntu and WSL:
   $sudo_command apt-get install python-pip

On macOS:
   # If you haven't, install homebrew from https://brew.sh/
   brew install python

On other systems: please see your OS documentation on how to install
pip.

"
   invocation_problems=1
fi

if [ -n "$invocation_problems" ]; then
    exit 1
fi

hard_detect_dpkg () {
    dpkg-query --status "$1" 2>/dev/null | grep '^Status:.* installed' >/dev/null
}

check_deb_dependencies () {
    critical="$(cat <<EOF
build-essential
libffi-dev
python-dev
python-pip
EOF
)"

    packages_not_found=""
    for pkg in $critical; do
	if ! hard_detect_dpkg "$pkg"; then
	    echo "*** Missing package: $pkg"
	    packages_not_found+=" $pkg"
	else
	    echo "Found: $pkg"
	fi
    done

    if [ -n "$packages_not_found" ]; then
	echo "-------"
	echo "Setup will fail without these packages. To install them:"
	echo ""
	echo -n "$sudo_command apt-get install "
	# explicitly want word-spliting here
	# shellcheck disable=SC2086
	echo $packages_not_found
	echo
	exit 1
    else
	echo
	echo "Found all critical packages."
	echo
    fi
}

if [ -f /etc/debian_version ]; then
    echo
    echo "This system appears to be running Ubuntu or Debian. Checking"
    echo "for critical packages."
    echo
    check_deb_dependencies
fi

die () {
    echo "$@"
    exit 1
}

sudo_pip () {
    # pip complains loudly about directory permissions when sudo without -H.
    $sudo_for_pip_install pip $quiet "$@"
}

our_pip () {
    pip $quiet "$@"
}

our_pip_install () {
    our_pip install "$@"
}

# An easy way to see if Homebrew is installed.
if brew command command >/dev/null 2>&1; then
    # If it is, we get our virtualenv as a regular user
    our_pip_install virtualenv
else
    # We may not need this installed as root; we just need it on
    # $PATH somewhere. But do root for now.
    sudo_pip install virtualenv
fi

# In case we have a new virtualenv executable.
hash -r

if ! virtualenv "$1"; then
    dn="$(dirname "$1")"
    echo "
virtualenv failed to create directory '$1'. Note that $1 must not exist, but
its parent ($dn) must exist.
"
    exit 1
fi

[ -d "$1" ] || die "Missing venv directory $1! Something badly wrong."

# This mucks around with our environment variables. We know where it
# is at shellcheck time.

# shellcheck disable=SC1090
source "$1/bin/activate"

# Below this line, we are only installing into the virtualenv at "$1"

our_pip_install --upgrade pip 

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
apache-libcloud>=1.5.0 pycrypto
linode-python
pyrax
EOF
)"

# We want word splitting.
# shellcheck disable=SC2059,SC2086
our_pip_install $packages

echo "
*************

All dependencies installed into $1. To use this environment, run this
in your shell:

    source \"$1/bin/activate\"

You need to do this once in every terminal window you plan to run the
command './streisand' in.

After you've run that, you're ready to run ./streisand.
"
