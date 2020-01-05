#!/bin/bash
#
# This is intended to be sourced into a deploy script. It exists to DRY up the
# codebase. It expects the following variables set:
#
# DEFAULT_SITE_VARS /path/to/default-site.yml
# GLOBAL_VARS /path/to/globals.yml
# INVENTORY /path/to/inventory
# PROJECT_DIR /path/to/streisand
# SITE_VARS /path/to/site.yml
# PLAYBOOK /path/to/playbook.yml.
#

set -o errexit

ansible-playbook \
  --extra-vars="@${GLOBAL_VARS}" \
  --extra-vars="@${DEFAULT_SITE_VARS}" \
  --extra-vars="@${SITE_VARS}" \
  "${PROJECT_DIR}/playbooks/validate.yml"

# Update the server.
ansible-playbook \
  -i "${INVENTORY}" \
  --extra-vars="@${GLOBAL_VARS}" \
  --extra-vars="@${DEFAULT_SITE_VARS}" \
  --extra-vars="@${SITE_VARS}" \
  "${PLAYBOOK}"
