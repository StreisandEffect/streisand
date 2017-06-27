CI Testing
==========================

Streisand has a `.travis.yml` file that powers [continuous integration
tests](https://travis-ci.org/jlund/streisand). It works by installing required
test tools (e.g. shellcheck) and an Ansible environment on a Ubuntu Trusty
(14.04) machine.

The `test.sh` wrapper script
--------------------------------

The `test/test.sh` wrapper script is invoked to perform tests and supports
an argument for specifying what actions should be taken. The following are
supported arguments:

* **"setup"** prepares the local environment for running a Streisand
    [LXC](https://linuxcontainers.org/lxc/introduction/) instance. The instance
    is managed via [LXD](https://linuxcontainers.org/lxd/).

* **"syntax"** checks the Streisand playbooks for Ansible syntax errors.

* **"run"** runs the CI tests. It assumes the local environment is already
    prepared from a previous "setup" run.

* **"ci"** combines "setup" and "run".

* **"full"** performs the same as "ci" but additionally adds verbose output to
    the Ansible run. This is very verbose but can be useful for diagnosing
    tricky broken builds.

* By **default** the wrapper will run "syntax".

Working around things that won't work in Travis
-----------------------------------------------

Some playbooks/tasks can't be run in CI because of limitations imposed by the
containerization or Travis. One example of this is installing a Tor relay. To
work around this playbooks/tasks that break in CI can be gated on the
`streisand_ci` variable, which is `true` only for CI runs. Where possible it's
best to minimize the use of this variable for conditional execution because we
want as much code to be tested as possible!

Kernel Modules
---------------------

By design LXC containers share the Linux kernel they use with the host machine.
This means playbooks/services that require a kernel module (e.g. Libreswan) must
build the kernel module on the host machine.


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
4. To re-run the Streisand playbooks, the virtual machines can be re-provisioned
   with:

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
4. To re-run the Streisand playbooks, the virtual machines can be re-provisioned
   with:

       VAGRANT_VAGRANTFILE=Vagrantfile.remotetest vagrant up --provision

Misc Tricks
==========================

* Uncomment the lines setting the `ansible.verbose` value in the Vagrantfiles to
  increase the verbosity of the Ansible playbook runs.
* Skip the `./tests/remote_test.sh` prompts using `printf`:

       STREISAND_SERVER_IP=XX.XX.XX.XX; STREISAND_PASSWORD='gateway-password-goes-here'; printf "$STREISAND_SERVER_IP\n$STREISAND_PASSWORD\n" | ./tests/remote_test.sh
