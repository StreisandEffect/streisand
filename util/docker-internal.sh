#!/bin/bash
set -e

if [ "$PWD" != /work/streisand ]; then
    echo "
This script performs initial setup for Docker containers. It's invoked
automatically.

/work/streisand does not exist, so this is probably not being run
inside the container.
"
    exit 1
fi

if [ ! -d /work/sshkeys ]; then
    echo "
/work/sshkeys does not exist; it should have been set up by the 
'docker run' command line.
"    
    exit 1;
fi

if [ "$(ls /work/sshkeys | wc)" = 0 ]; then
    echo "
There are no files in /work/sshkeys (copied from $HOME/.ssh/)
and Streisand requires at least one ssh keypair. Generate one
with 'ssh-keygen'.
"
fi

# The files will be owned by the wrong uid unless we fix them up.

echo -n "Copying $HOME/.ssh/ into the container's /root/.ssh..."
mkdir -p /root/.ssh
cp -r /work/sshkeys/* /root/.ssh/

chown -R root:root /root/.ssh
chmod -R g-rwx,o-rwx /root/.ssh/
echo "done."
echo

# Get an ssh-agent, so we can prompt the user for passphrases early.
eval $(ssh-agent)

echo "Prompting for id_rsa password if necessary."

ssh-add /root/.ssh/id_rsa

exec "$@"
