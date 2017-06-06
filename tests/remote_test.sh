#!/usr/bin/env bash
#
# Utility script for running the Vagrantfile.remotetest against a Streisand host
#

# Set errexit option to exit immediately on any non-zero status return
set -e

echo -e "\n\033[38;5;255m\033[48;5;234m\033[1m  S T R E I S A N D  R E M O T E  T E S T\033[0m\n"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"

VAGRANT_FILENAME="Vagrantfile.remotetest"
GENERATED_DOCS_DIR="$SCRIPT_DIR/../generated-docs"
mkdir -p $GENERATED_DOCS_DIR

VAGRANTFILE="$SCRIPT_DIR/../$VAGRANT_FILENAME"

function backup_vagrantfile() {
  cp $VAGRANTFILE $VAGRANTFILE.dist
}

function restore_vagrantfile() {
  cp $VAGRANTFILE.dist $VAGRANTFILE
  rm $VAGRANTFILE.dist
}
trap restore_vagrantfile EXIT

# set_remote_ip replaces the "REMOTE_IP_HERE" token from the
# Vagrantfile.remotetest with the response from a user prompt
function set_remote_ip() {
  read -r -p "What is the Streisand server IP? " SERVER_IP
  sed "s/\"REMOTE_IP_HERE\",/\"$SERVER_IP\",/" "$VAGRANTFILE" > "$VAGRANTFILE.new"
  mv "$VAGRANTFILE.new" "$VAGRANTFILE"
}

function set_gateway_pass() {
  local GATEWAY_PASS_FILE="$GENERATED_DOCS_DIR/gateway-password.txt"

  read -r -p "What is the Streisand gateway password? " GATEWAY_PASS

  echo "$GATEWAY_PASS" > $GATEWAY_PASS_FILE
}

backup_vagrantfile
set_remote_ip
set_gateway_pass

pushd "$SCRIPT_DIR/.."
  VAGRANT_VAGRANTFILE=$VAGRANT_FILENAME vagrant up --provision
popd
