#!/usr/bin/env bash
#
# Provision an existing cloud server.
#
# This requires an expanded extra-vars file specific to the provider type that
# sets all of the values gathered by prompts in the interactive installation.
# See the contents of global_vars/noninteractive for examples that can be copied
# and modified.
#
# Usage:
#
# streisand-existing-cloud-server \
#   --ssh-user root \
#   --ip-address 10.10.10.10 \
#   --site-config path/to/digitalocean-site.yml
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
$0 \\
  --ssh-user root \\
  --ip-address 10.10.10.10 \\
  --site-config path/to/site.yml

If no SSH user is specified, then the root user will be used.

If no configuration file is specified, then ~/.streisand/site.yml will be used
if it exists, or global_vars/default-site.yml will be used otherwise.
EOF
}

SSH_USER=""
IP_ADDRESS=""
SITE_VARS=""

while [[ ${#} -gt 0 ]]; do
  case "${1}" in
    # Required.
    --ip-address)    IP_ADDRESS="${2}"; shift;;

    # Optional.
    --site-config)   SITE_VARS="${2}"; shift;;
    --ssh-user)      SSH_USER="${2}"; shift;;

    # Utility.
    -h|--help)       usage; exit 0;;
    --)              break;;
    -*)              echo "Unrecognized option ${1}"; usage; exit 1;;
  esac

  shift
done

# --------------------------------------------------------------------------
# Fail if required options are not set.
# --------------------------------------------------------------------------

if [ -z "${IP_ADDRESS}" ]; then
  usage
  exit 1
fi

# --------------------------------------------------------------------------
# Default if no parameter is provided.
# --------------------------------------------------------------------------

if [ -z "${SSH_USER}" ]; then
  echo "Defaulting to SSH user: root"
  SSH_USER="root"
fi

# --------------------------------------------------------------------------
# Sort out the SITE_VARS value based on input and defaults.
# --------------------------------------------------------------------------

# shellcheck source=util/source_check_and_default_site_vars.sh
source "${PROJECT_DIR}/util/source_check_and_default_site_vars.sh"

# --------------------------------------------------------------------------
# Onwards to launch and provision the server.
# --------------------------------------------------------------------------

export INVENTORY="${PROJECT_DIR}/inventories/inventory-existing"

# Create an inventory file on the fly.
cat > "${INVENTORY}" <<EOF
[localhost]
localhost ansible_connection=local ansible_python_interpreter=python
[streisand-host]
${IP_ADDRESS} ansible_user=${SSH_USER}
EOF

export PLAYBOOK="${PROJECT_DIR}/playbooks/existing-server.yml"

# Run the validation and deployment. This expects the variables set here.
# shellcheck source=util/source_validate_and_deploy.sh
source "${PROJECT_DIR}/util/source_validate_and_deploy.sh"
