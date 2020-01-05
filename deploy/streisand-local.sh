#!/usr/bin/env bash
#
# Run a noninteractive Streisand installation on the local machine.
#
# This requires an expanded extra-vars file specific to the provider type that
# sets all of the values gathered by prompts in the interactive installation.
# See the contents of global_vars/noninteractive for examples that can be copied
# and modified.
#
# Usage:
#
# streisand-local --site-config path/to/local-site.yml
#

set -o errexit
set -o nounset

DIR="$( cd "$( dirname "$0" )" && pwd)"
PROJECT_DIR="${DIR}/.."

export DEFAULT_SITE_VARS="${PROJECT_DIR}/global_vars/default-site.yml"
export GLOBAL_VARS="${PROJECT_DIR}/global_vars/globals.yml"

# Include the check_ansible function from ansible_check.sh.
# shellcheck source=util/source_validate_and_deploy.sh
source "${PROJECT_DIR}/util/ansible_check.sh"
check_ansible

# --------------------------------------------------------------------------
# Reading options.
# --------------------------------------------------------------------------

function usage () {
  cat <<EOF
Usage:
$0 --site-config path/to/site.yml

If no configuration file is specified, then ~/.streisand/site.yml will be used
if it exists, or global_vars/default-site.yml will be used otherwise.
EOF
}

SITE_VARS=""

while [[ ${#} -gt 0 ]]; do
  case "${1}" in
    # Optional.
    --site-config)   SITE_VARS="${2}"; shift;;

    # Utility.
    -h|--help)       usage; exit 0;;
    --)              break;;
    -*)              echo "Unrecognized option ${1}"; usage; exit 1;;
  esac

  shift
done

# --------------------------------------------------------------------------
# Sort out the SITE_VARS value based on input and defaults.
# --------------------------------------------------------------------------

# shellcheck source=util/source_check_and_default_site_vars.sh
source "${PROJECT_DIR}/util/source_check_and_default_site_vars.sh"

# --------------------------------------------------------------------------
# Onwards to provision the local machine.
# --------------------------------------------------------------------------

export INVENTORY="${PROJECT_DIR}/inventories/inventory-local-provision"
export PLAYBOOK="${PROJECT_DIR}/playbooks/localhost.yml"

# Run the validation and deployment. This expects the variables set here.
# shellcheck source=util/source_validate_and_deploy.sh
source "${PROJECT_DIR}/util/source_validate_and_deploy.sh"
