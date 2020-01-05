# Advanced installation

### Running Streisand to Provision Localhost ###

If you can't run Streisand in the normal manner (running from your client home machine/laptop to configure a remote server) Streisand supports a local provisioning mode for **machines running Ubuntu 16.04**. After following the basic instructions, choose "Localhost (Advanced)" from the menu after running `./streisand`.

**Note:** Running Streisand against localhost can be a destructive action! You will be potentially overwriting configuration files and must be certain that you are affecting the correct machine.

**Note:** The machine must be running Ubuntu 16.04.

**Note:** If you have an external firewall available, see the `generated-docs` directory for a `-firewall-information.html` document with information on which ports need to be opened.

### Running Streisand on Other Providers ###

You can also run Streisand on a new Ubuntu 16.04 server. Dedicated hardware? Great! Esoteric cloud provider? Awesome! To do so, simply choose "Existing Server (Advanced)" from the menu after running `./streisand` and provide the IP address of the existing server when prompted.

The server must be accessible using the `$HOME/.ssh/id_rsa` SSH Key, and **root** is used as the connecting user by default. If your provider requires you to SSH with a different user than root (e.g. `ubuntu`) specify the `ANSIBLE_SSH_USER` environmental variable (e.g. `ANSIBLE_SSH_USER=ubuntu`) when you run `./streisand`.

**Note:** Running Streisand against an existing server can be a destructive action! You will be potentially overwriting configuration files and must be certain that you are affecting the correct machine.

**Note:** The machine must be running Ubuntu 16.04.

**Note:** If you have an external firewall available, see the `generated-docs` directory for a `-firewall-information.html` document with information on which ports need to be opened.

### Noninteractive Deployment ###

Alternative scripts and configuration file examples are provided for
noninteractive deployment, in which all of the required information is passed
on the command line or in a configuration file.

Example configuration files are found under `global_vars/noninteractive`. Copy
and edit the desired parameters, such as providing API tokens and other choices,
and then run the appropriate script.

To deploy a new Streisand server:

      deploy/streisand-new-cloud-server.sh \
        --provider digitalocean \
        --site-config global_vars/noninteractive/digitalocean-site.yml

To run the Streisand provisioning on the local machine:

      deploy/streisand-local.sh \
        --site-config global_vars/noninteractive/local-site.yml

To run the Streisand provisioning against an existing server:

      deploy/streisand-existing-cloud-server.sh \
        --ip-address 10.10.10.10 \
        --ssh-user root \
        --site-config global_vars/noninteractive/digitalocean-site.yml

