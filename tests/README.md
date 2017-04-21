# Streisand-CI testing
Streisand CI testing. Uses travis-ci to test Ansible syntax and kick off a full playbook run.
Full playbook run uses LXC to execute.

## Limitations
The TOR playbook role is skipped. Turns out the travis-ci environment doesn't like being added to the tor network (even temporarily for testing purposes).
Streisand doc generation is also skipped for now until some mock variables are added for the skipped TOR role.

## Local Testing
You can use this testing framework locally as well (Locally, the TOR playbook will be ran).

Environment Expectations:
  - *Fresh* trusty or xenial ubuntu install (Vagrant or digital ocean server, etc.)

Running the tests:
Since LXC loads the hosts kernal modules, Libreswan is compiled and installed on the host. This allows the ipsec role to complete successfully

  Running all tests:
    - Clone the Streisand repository
    - Run test script
      - `./tests/test.sh full`
        - This will setup LXD/LXC and dependencies locally. Then run streisand against the streisand LXC container.
  Sytanx only:
    - `./tests/test.sh syntax` 

# TODO
- Vagrant file which can automate setting up a local test environment for use with development-setup.yml, and run.yml
- Figure out a way to test the TOR role
- Add some mock variables for the document generation task
- Would be cool to automate tests with each provider( Example: Automatically spinning up an EC2 instance and testing)
- Add some automated client testing (Example: Automatically test an openvpn client)
