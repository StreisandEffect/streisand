#!/bin/bash
#
# This is intended to be sourced into a deploy script. It exists to DRY up the
# codebase. It expects the following variables set:
#
# DEFAULT_SITE_VARS /path/to/default-site.yml
# PROJECT_DIR /path/to/streisand
# SITE_VARS /path/to/site.yml
#

set -o errexit

# If no site vars file is provided, then use one of the two default options.
if [ -z "${SITE_VARS}" ]; then

  SITE_VARS="${HOME}/.streisand/site.yml"

  if [ ! -f "${SITE_VARS}" ]; then
    SITE_VARS="${DEFAULT_SITE_VARS}"
  fi

  echo "Using default config file: ${SITE_VARS}"
fi

# Make sure the alleged configuration file exists.
if [ ! -f "${SITE_VARS}" ]; then
  echo "No such config file: ${SITE_VARS}"
  exit 1
fi
