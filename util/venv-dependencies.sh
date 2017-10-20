#!/bin/bash
set -e

# quiet=--quiet
quiet=

#### Options end here.

willexit=
if [ "$#" -ne 1 ]; then
   echo "
Usage: $0 new-directory

This script installs Streisand builder dependencies. It depends on
a working Python 2.7 'pip' command on your PATH. I'll install 
virtualenv for you, but on Linux, this requires sudo access.

'new-directory' must be somewhere you can write to. I suggest
$HOME/streisand-deps. 
"
   willexit=1
fi

if ! pip >/dev/null; then
   echo "
You need a working 'pip' command. To get one:

On Ubuntu and WSL: (XXX debian?)
   sudo apt-get install python-pip

On macOS:
   # If you haven't, install homebrew from https://brew.sh/
   brew install python
"
   willexit=1
fi

if [ -n "$willexit" ]; then
    exit 1
fi

die () {
    echo "$@"
    exit 1
}

sudo_pip () {
    # pip complains loudly about directory permissions when sudo without -H.
    sudo -H pip $quiet "$@"
}

our_pip () {
    pip $quiet "$@"
}

our_pip_install () {
    our_pip install "$@"
}

# An easy way to see if Homebrew is installed.
if brew command command >/dev/null; then
    # If it is, we get our virtualenv as a regular user
    our_pip_install virtualenv
else
    # We may not need this installed as root; we just need it on
    # $PATH somewhere. But do root for now.
    sudo_pip install virtualenv
fi

# In case we have a new virtualenv.
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

our_pip_install "ansible"

packages="$(cat <<EOF
boto boto3
msrest msrestazure azure==2.0.0rc5 packaging
dopy==0.3.5
apache-libcloud>=1.5.0
linode-python
pyrax
EOF
)"

# We want word splitting.
# shellcheck disable=SC2059,SC2086
our_pip_install $packages

echo "
*************

All dependencies installed into $1. To use this environment, run 
this in your shell before running Streisand:

    source \"$1/bin/activate\"

After you've run that, you're ready to run ./streisand.
"
