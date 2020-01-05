#!/bin/bash -e

# randomize_sitevar.sh takes a Streisand site vars yml file and randomly enables
# some # of services. It guarantees that at least one service is enabled. It
# operates *destructively* - it will disable all services in the yml file before
# enabling a random selection. The site var yml contents are changed in-place.

# Keep track of how many services we've enabled so we can check there was at
# least one enabled.
ENABLED_SERVICES=0

# randomize_services mutates a site vars file provided as the first argument
function randomize_services {
  # Reset the state of the file to all disabled
  sed -i 's/yes/no/' "$1"

  # NOTE(@cpu): You might be tempted to pipe the `grep` into `read` for the
  # `while` condition. This will make the loop body excute in a subshell that
  # can not increment `ENABLED_SERVICES`. To work around this we use process
  # substitution. See http://mywiki.wooledge.org/BashFAQ/024 for more
  while read -r LINE
  do
    # Generate a random int between 0 and 100
    FLIP=$((RANDOM%100))
    # If the random int is >= 50, enable the service
    if [ "$FLIP" -gt 50 ]
    then
      SERVICE=$(echo "$LINE" | cut -d: -f1)
      case $SERVICE in
        "streisand_stunnel_enabled")
          # stunnel depends on openvpn
          echo "Setting 'streisand_openvpn_enabled: yes' to support stunnel"
          sed -i "s/\(streisand_openvpn_enabled\): no/\1: yes/" "$1"
          ;;
        "streisand_tinyproxy_enabled"|"streisand_sshuttle_enabled")
          # tinyproxy and sshuttle depend on the ssh-forward user
          echo "Setting 'streisand_ssh_forward_enabled' to support tinyproxy"
          sed -i "s/\(streisand_ssh_forward_enabled\): no/\1: yes/" "$1"
          ;;
      esac

      ENABLED_SERVICES=$((ENABLED_SERVICES+1))
      echo "Setting '$SERVICE: yes'"
      sed -i "s/\($SERVICE\): no/\1: yes/" "$1"
    fi
  done < <(grep "no" "$1")
}

# Check that the provided site vars file exists
if [ ! -e "$1" ]
then
  echo "site vars file \"$1\" does not exist"
  exit 1
fi

# Until we've enabled at least one service continue to randomize the input file
while [ "$ENABLED_SERVICES" -eq "0" ]
do
  randomize_services "$1"
done

echo "Enabled $ENABLED_SERVICES random services"
