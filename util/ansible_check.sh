# shellcheck shell=bash

# This is included by the main streisand script.

# check_ansible checks that Ansible is installed on the local system
# and that it is a supported version.
function check_ansible() {
  local REQUIRED_ANSIBLE_VERSION="2.8.4"

  if ! command -v ansible > /dev/null 2>&1; then
    echo "
Streisand requires Ansible and it is not installed.
Please see the README Installation section on Prerequisites"
    exit 1
  fi

  ansible_version="$(ansible --version | head -1 | grep -oe '2[.0-9]*')"

  if ! ./util/version_at_least.py "$REQUIRED_ANSIBLE_VERSION" "$ansible_version" ; then
      echo "
Streisand requires Ansible version $REQUIRED_ANSIBLE_VERSION or higher.
This system has Ansible $ansible_version.
"
      exit 1
  fi
}
