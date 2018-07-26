#!/bin/bash
#
# Streisand shellcheck wrapper
#
# This test script finds all of the *.sh shell files in the project tree and
# runs shellcheck against them. 
#

# Fail on errors
set -e

# Ensure shellcheck is present
if ! command -v shellcheck > /dev/null 2>&1; then
    echo "The 'shellcheck' comand was not found in your PATH. Please install it"
    exit 1
fi

# NOTE(@cpu): We use -x to follow `source` directives across files
SHELLCHECK_ARGS=(-x)

# Determine the absolute path of this script file's directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
# The Streisand project directory is one up from this script's directory, tests/
PROJECT_DIR="$SCRIPT_DIR/.."

pushd "$PROJECT_DIR"
  # Run shellcheck against all of the `.sh` script files in the Streisand
  # project directory. Ignore any `venv` directory.
  #
  # NOTE(@cpu): While tempting to -exec shellcheck directly from find this will
  # eat-up any non-zero exit codes :-( Instead we find the files first and then
  # xargs shellcheck on the found files.
  find . -path "./venv" -prune -or -name '*.sh' -print0 | xargs -0 -n1 shellcheck "${SHELLCHECK_ARGS[@]}"

  # Also explicitly run `shellcheck` against the streisand wrapper script since
  # it doesn't end in .sh
  shellcheck "${SHELLCHECK_ARGS[@]}" "$PROJECT_DIR/streisand"
popd
