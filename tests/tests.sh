#!/usr/bin/env bash
# Streisand CI test script.
# Usage:
#  ./tests.sh [setup|syntax|run|ci|full]

# Set errexit option to exit immediately on any non-zero status return
set -e

echo -e "\n\033[38;5;255m\033[48;5;234m\033[1m  S T R E I S A N D  \033[0m\n"

# Compute an absolute path to the test ansible.cfg file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export ANSIBLE_CONFIG=$DIR/ansible.cfg

# Include the check_ansible function from ansible_check.sh
source util/ansible_check.sh

function run_playbook {
  PLAYBOOK="$1"
  EXTRA_FLAGS=(${@:2})
  ansible-playbook -i "$DIR/inventory" "$PLAYBOOK" "${EXTRA_FLAGS[@]}"
}

# syntax_check runs `ansible-playbook` with `--syntax-check` to vet Ansible
# playbooks for syntax errors
function syntax_check {
  run_playbook "$DIR/syntax-check.yml" --syntax-check -vv
}

function dev_setup {
  run_playbook "$DIR/development-setup.yml"
}

function run_tests {
  run_playbook "$DIR/run.yml" -e streisand_ci=true "$1"
}

function ci_tests {
  dev_setup && run_tests
}

function ci_tests_verbose {
  dev_setup && run_tests -vv
}

# Make sure the system is ready for the Streisand playbooks
check_ansible

case $1 in
  # Setup only prepares the local environment for running a Streisand LXC
  "setup")
    dev_setup
    ;;
  # Syntax only checks for Ansible syntax errors
  "syntax")
    syntax_check
    ;;
  # Run will run CI tests assuming the local environment is already prepared
  "run")
    run_tests
    ;;
  # CI will setup the local environment and then run tests
  "ci")
    ci_tests
    ;;
  # Full will do the same as "ci" but with verbose output
  "full")
    ci_tests_verbose
    ;;
  # By default, just run a syntax_check
  *)
    syntax_check
    ;;
esac
