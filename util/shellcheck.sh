#!/bin/bash
#
# Streisand shellcheck wrapper
#
# This util script finds all of the *.sh shell files in the project tree and
# runs shellcheck against them. 
#

# Fail on errors
set -e

# Ensure shellcheck is present
if ! command -v shellcheck > /dev/null 2>&1; then
    echo "The 'shellcheck' comand was not found in your PATH. Please install it"
    exit 1
fi

# Determine the absolute path of this script file
thisScript=$(realpath "$0")

# Move backwards into the Streisand project directory from util/
pushd "$(dirname "$thisScript")/.."
  # Run shellcheck against all of the `.sh` script files in the Streisand
  # project directory.
  # NOTE(@cpu): We use -x to follow `source` directives across files
  find ./ -name '*.sh' -exec shellcheck -x {} \;
popd
