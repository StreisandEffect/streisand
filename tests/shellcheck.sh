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

# Determine the absolute path of this script file's directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"

# Move backwards into the Streisand project directory from tests/ subdir
pushd "$SCRIPT_DIR/.."
  # Run shellcheck against all of the `.sh` script files in the Streisand
  # project directory.
  # NOTE(@cpu): We use -x to follow `source` directives across files
  find ./ -name '*.sh' -exec shellcheck -x {} \;
popd
