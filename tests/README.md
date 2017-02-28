# Streisand-CI Testing
Streisand CI testing uses Travis CI to test Ansible syntax and kick off a full playbook run.
The Full playbook run is executed against an LXC container.

## Testing Limitations
There were some connectivity issues with the `tor-bridge` playbook in the Travis CI testing environment. Due to this, the role is currently skipped.
Streisand doc generation is also skipped until some mock variables and tasks are added.

## Local Testing
You can use this testing framework to test locally as well. Note that when testing locally, the `tor-bridge` role will be ran.

### Host Environment Expectations:
  - **Fresh** Trusty or Xenial Ubuntu install (Vagrant or DigitalOcean server, etc.)

Because LXC loads the host's kernal modules into the container. Libreswan needs to be compiled and installed on the host.
This allows the ipsec role to complete successfully inside the LXC container.

#### Running the tests
  - Clone the Streisand repository
    - Run test script
      - `./tests/test.sh full`
        - The `full` argument will run `development-setup.yml`, `syntax-check.yml`, and `run.yml`.

#### Syntax only
  - `./tests/test.sh syntax`

# TODO
- Vagrant file which can automate setting up a local test environment for use with development-setup.yml, and run.yml
- Figure out a way to test the Tor role
- Add some mock variables for the document generation task
- Add some automated client testing (Example: Automatically test an openvpn client)
