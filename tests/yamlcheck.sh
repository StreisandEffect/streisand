#!/bin/bash
#
# Streisand yamllint wrapper
#
# This test script finds all of the *.yml files in the project tree and
# runs yamllint against them. Ignore any `venv` directory.
#

# Fail on errors
set -e

# Ensure yamllint is present
if ! command -v yamllint > /dev/null 2>&1; then
    echo "The 'yamllint' command was not found in your PATH."
    echo "Please run 'pip install yamllint' to install."
    exit 1
fi

# Determine the absolute path of this script file's directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
# The Streisand project directory is one up from this script's directory, tests/
PROJECT_DIR="$SCRIPT_DIR/.."

# Streisand specifies a custom yamllint config to adjust what rules are applied
YAMLLINT_ARGS=(-c "$SCRIPT_DIR/yamllint-config.yml")

pushd "$PROJECT_DIR"
  # Run yamllint against all of the `.yml` files in the Streisand
  # project directory.
  #
  # NOTE(@cpu): While tempting to -exec shellcheck directly from find this will
  # eat-up any non-zero exit codes :-( Instead we find the files first and then
  # xargs yamllint on the found files.
  find . -path "./venv" -prune -or -name '*.yml' -print0 | xargs -0 -n1 yamllint "${YAMLLINT_ARGS[@]}"
popd
