#!/usr/bin/env bash
# Streisand syntax check.
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export ANSIBLE_CONFIG=$DIR/ansible.cfg

command -v ansible > /dev/null 2>&1 || {
  echo "Ansible is not installed."
  exit 1
}

required_ansible_version="2.3.0.0"

if [[ "$(ansible --version | grep -oe '2\(.[0-9]\)*')" < $required_ansible_version ]]
then
    echo "Ansible $required_ansible_version or higher is required."
    exit 1
fi

if [ -z "$*" ]; then ansible-playbook -i $DIR/inventory $DIR/syntax-check.yml --syntax-check -vv ; fi

if [[ $1 = "ci" ]]; then  ansible-playbook -i $DIR/inventory $DIR/development-setup.yml && ansible-playbook -i $DIR/inventory $DIR/run.yml -e streisand_ci=true; fi
if [[ $1 = "full" ]]; then  ansible-playbook -i $DIR/inventory $DIR/development-setup.yml -vv && ansible-playbook -i $DIR/inventory $DIR/run.yml -vv -e streisand_ci=false; fi
if [[ $1 = "run" ]]; then  ansible-playbook -i $DIR/inventory $DIR/run.yml -e streisand_ci=false -vv; fi
if [[ $1 = "setup" ]]; then  ansible-playbook -i $DIR/inventory $DIR/development-setup.yml -vv; fi
if [[ $1 = "syntax" ]]; then ansible-playbook -i $DIR/inventory $DIR/syntax-check.yml --syntax-check -vv ; fi
