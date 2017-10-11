#!/bin/bash

# Set errexit option to exit immediately on any non-zero status return
set -e

# check_ansible checks that Ansible is installed on the local system
# and that it is a supported version.
function check_ansible() {
  local REQUIRED_ANSIBLE_VERSION="2.3.0"

  if ! command -v ansible > /dev/null 2>&1; then
    echo "
Streisand requires Ansible and it is not installed.
Please see the README Installation section on Prerequisites"
    exit 1
  fi

  if [[ $(ansible --version | grep -oe '2\(.[0-9]\)*') < $REQUIRED_ANSIBLE_VERSION ]]; then
      echo "
Streisand requires Ansible version $REQUIRED_ANSIBLE_VERSION or higher.
This system has Ansible $(ansible --version)."
      exit 1
  fi
}
