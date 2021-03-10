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
Usage: $0 ./venv

This script creates an isolated Python virtualenv at './venv', and
installs Ansible and dependencies into it.

The script depends on Python 3.5 or later.

If this system is running Debian or Ubuntu, this script will also
check for other packages needed to install.

Although './venv' is recommended, you can specify another location to
create the virtualenv. If the location already exists, it should be an
existing virtualenv to overwrite.

"
}

is_root=""
if [ "$(id -u)" == "0" ]; then
    is_root=1
fi


python="python3"
sudo_command="sudo"
sudo_for_pip_install="sudo -H"

# If we're root, get rid of sudo--it may not be there...
if [ -n "$is_root" ]; then
    sudo_command=""
    sudo_for_pip_install=""
fi

request_python_3 () {
    echo "
On Debian, Ubuntu, and WSL:
   $sudo_command apt install python3 python3-pip python3-virtualenv

On macOS:
   # If you haven't, install homebrew from https://brew.sh/
   brew install python

On other systems: please see your OS documentation on how to install
Python 3.
"
    exit 1
}

ensure_python_3_5 () {
    python_version=$($python --version 2>&1)
    if [[ $python_version < "Python 3.5" ]]; then
	echo "

The $python command invokes $python_version. Python 3.5 or later is
required.
"
	return 1
    fi
    return 0
}

if [ "$#" -ne 1 ]; then
   usage
   exit 1
fi

if type -p $python >/dev/null; then
    echo "Found a python3 command...."
    if ! ensure_python_3_5; then
	request_python_3
	exit 1
    fi
else
    echo "The command 'python3' doesn't appear to exist. Trying 'python'..."
    python='python'
    if ! type -p $python >/dev/null; then
	echo "

On your system, neither 'python3' or 'python' exist as commands. Please
install Python 3.5 or later.

"
	request_python_3
	exit 1
    fi
    if ! ensure_python_3_5; then
	request_python_3
	exit 1
    fi
fi

# Whew. We now have a working Python 3.5 or later in $python.

hard_detect_dpkg () {
    dpkg-query --status "$1" 2>/dev/null | grep '^Status:.* installed' >/dev/null
}

check_deb_dependencies () {
    critical="$(cat ./util/dependencies.txt)"
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

if ! $python -m venv -h >/dev/null; then
    echo "

The command 'python -m venv -h' failed. The venv module is a standard
part of Python, and this script can't proceeed without it. Please
report details of your system to the authors of this package if stuck.
The output of 'python -m venv' is:

"
    $python -m venv -h
    exit 1
fi

# We want to run some tests on the parent of the path on the command
# line.
parent_dirname="$(dirname "$1")"

if [ ! -d "$parent_dirname" ]; then
    die "
The parent directory of $1 ($parent_dirname) does not exist. Please
specify a parent directory you can write to. './venv' is a good choice.

"
fi

if [ ! -w "$parent_dirname" ]; then
    die "
The parent directory of $1 ($parent_dirname) is not writable. Please specify a
parent directory you can write to. './venv' is a good choice.

"
fi

# The virtualenv directory should be created from scratch. But if the
# directory already exists *and* it looks like it was a virtualenv,
# don't pester the user; just use "virtualenv --clear" to clean it out.

# In any case, this script will not run "rm -rf $1", regardless of how
# tempting.

if [ -e "$1" ]; then
    if [ ! -e "$1/bin/activate.csh" ]; then
	die "
The directory $1 already exists, and it does not appear to contain a
Python virtualenv. Please specify a new directory to be
created. './venv' is a good choice if it doesn't exist.

"
    fi
fi

sudo_pip () {
    # shellcheck disable=SC2086
    # pip complains loudly about directory permissions when sudo without -H.
    $sudo_for_pip_install pip3 $quiet "$@"
}

our_pip () {
    # shellcheck disable=SC2086
    pip3 $quiet "$@"
}

our_pip_install () {
    our_pip install "$@"
}

NO_SITE_PACKAGES=""

# shellcheck disable=SC2086
if ! $python -m venv --clear $NO_SITE_PACKAGES "$1"; then
    parent_dirname="$(dirname "$1")"
    echo "
'python -m venv' failed to create directory '$1'

Note that $1 must not exist, but its parent ($parent_dirname) must
exist.

The first argument, 'new-directory', must be somewhere you can write
to. A good place is './venv'. If it already exists, please delete the
directory, or use a different name.

"
    exit 1
fi

[ -d "$1" ] || die "Missing venv directory $1! Something badly wrong."

# This mucks around with our environment variables. We know where it
# is at shellcheck time.

# shellcheck disable=SC1090
source "$1/bin/activate"

# Below this line, we are only installing into the virtualenv at "$1"

our_pip_install --upgrade 'pip < 21.0'

# The pip we want should be in our path now. Make sure we use it.
hash -r

# Now we can install all the Python modules.
our_pip_install -r requirements.txt

echo "
*************

All dependencies installed into $1. To use this environment, run this
in your shell:

    source \"$1/bin/activate\"

You need to do this once in every terminal window you plan to run the
command './streisand' in.

After you've run that, you're ready to run ./streisand.
"
