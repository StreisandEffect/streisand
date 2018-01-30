Installation
------------
Please read all installation instructions **carefully** before proceeding.

### Important Clarification ###
Streisand is based on [Ansible](http://www.ansible.com/home), an automation tool that is typically used to provision and configure files and packages on remote servers. Streisand automatically sets up **another remote server** with the VPN packages and configuration.

Streisand will spin up and deploy **another server** on your chosen hosting provider when you run **on your home machine** (e.g. your laptop). Usually, you **do not run Streisand on the remote server** as by default this would result in the deployment of another server from your server and render the first server redundant (whew!).

In some circumstances advanced users may opt to use the local provisioning mode to have the system running Streisand/Ansible configure itself as a Streisand server. This is a configuration mode best reserved for when it isn't possible to install Ansible on your home machine or when your connection to a cloud provider is too unreliable for Ansible's SSH connections.

### Execution ###
1. Clone the Streisand repository and enter the directory.

       git clone https://github.com/StreisandEffect/streisand.git && cd streisand

   Or clone from the external mirror if GitHub is blocked.

       git clone https://area51.threeletter.agency/mirrors/streisand.git && cd streisand
2. Execute the Streisand script.

       ./streisand
3. Follow the prompts to choose your provider, the physical region for the server, and its name. You will also be asked to enter API information.
4. Once login information and API keys are entered, Streisand will begin spinning up a new remote server.
5. Wait for the setup to complete (this usually takes around ten minutes) and look for the corresponding files in the 'generated-docs' folder in the Streisand repository directory. The HTML file will explain how to connect to the Gateway over SSL, or via the Tor hidden service. All instructions, files, mirrored clients, and keys for the new server can then be found on the Gateway. You are all done!

### Running Streisand to Provision Localhost (Advanced) ###

If you can not run Streisand in the normal manner (running from your client home machine/laptop to configure a remote server) Streisand supports a local provisioning mode. Simply choose "Localhost (Advanced)" from the menu after running `./streisand`.

**Note:** Running Streisand against localhost can be a destructive action! You will be potentially overwriting configuration files and must be certain that you are affecting the correct machine.

### Running Streisand on Other Providers (Advanced) ###

You can also run Streisand on a new Ubuntu 16.04 server. Dedicated hardware? Great! Esoteric cloud provider? Awesome! To do so, simply choose "Existing Server (Advanced)" from the menu after running `./streisand` and provide the IP address of the existing server when prompted.

The server must be accessible using the `$HOME/id_rsa` SSH Key, and **root** is used as the connecting user by default. If your provider requires you to SSH with a different user than root (e.g. `ubuntu`) specify the `ANSIBLE_SSH_USER` environmental variable (e.g. `ANSIBLE_SSH_USER=ubuntu`) when you run `./streisand`.

**Note:** Running Streisand against an existing server can be a destructive action! You will be potentially overwriting configuration files and must be certain that you are affecting the correct machine.

### Noninteractive Deployment (Advanced) ###

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
