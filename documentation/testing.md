Local Testing
==========================

For local testing Streisand includes a `Vagrantfile` that creates two virtual
machines: `streisand-host` and `streisand-client`.

The `streisand-host` machine is provisioned with the standard Streisand
playbooks and replicates a Streisand server created with a cloud provider, but
running on your local computer.

The `streisand-client` machine is provisioned specifically to act as a client of
the `streisand-host`. It connects to the `streiand-host`'s HTTPS gateway to
download client configuration files that are used by test scripts to ensure that
services work "end-to-end".

Using Vagrant for Local Testing
-------------------------------

1. [Install Vagrant](https://www.vagrantup.com/docs/installation/)
2. Clone the Streisand repository and enter the directory.

       git clone https://github.com/jlund/streisand.git && cd streisand
3. If this is your first time following these steps, create & start the
   `streisand-host` and `streisand-client` virtual machines with:

       `vagrant up`
4. If you have already created the virtual machines and wish to re-run the
   Streisand playbooks then re-provision the virtual machines with:

       `vagrant up --provision`

Remote Testing
==========================

For testing an existing Streisand server there is a `Vagrantfile.remotetest`
Vagrantifle. As compared to the stock `Vagrantfile` for local testing the
`Vagrantfile.remotetest` Vagrantfile does not include a `streisand-host`
machine. This remotetest variant is useful to "smoke test" an existing
Streisand server, or to provide end-to-end testing of a cloud provisioner.

Using Vagrant for Remote Testing (Easy Way)
--------------------------------------------

1. [Install Vagrant](https://www.vagrantup.com/docs/installation/)
2. Clone the Streisand repository and enter the directory.

       git clone https://github.com/jlund/streisand.git && cd streisand
3. Run the `remote_test.sh` helper script and give it the remote server IP
   & gateway password when prompted:

       ./tests/remote_test.sh

Using Vagrant for Remote Testing (Hard Way)
--------------------------------------------
1. [Install Vagrant](https://www.vagrantup.com/docs/installation/)
2. Clone the Streisand repository and enter the directory.

       git clone https://github.com/jlund/streisand.git && cd streisand
3. Edit `Vagrantfile.remotetest` and replace the `streisand_ip` host variable
   with the IP of the remote server.
4. Create the `generated-docs/gateway-password.txt` file with the gateway
   password of the Streisand server
5. If this is your first time following these steps, create & start the
   `streisand-client` virtual machine with:

       VAGRANT_VAGRANTFILE=Vagrantfile.remotetest vagrant up
6. If you have already created the client virtual machine and wish to re-run the
   client test playbooks then re-provision the client machine with:

       VAGRANT_VAGRANTFILE=Vagrantfile.remotetest vagrant up --provision

Misc Tricks
==========================

* Uncomment the lines setting the `ansible.verbose` value in the Vagrantfiles to
  increase the verbosity of the Ansible playbook runs.
* Skip the `./tests/remote_test.sh` prompts using `printf`:

       STREISAND_SERVER_IP=XX.XX.XX.XX; STREISAND_PASSWORD='gateway-password-goes-here'; printf "$STREISAND_SERVER_IP\n$STREISAND_PASSWORD\n" | ./tests/remote_test.sh
