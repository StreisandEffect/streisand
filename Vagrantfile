Vagrant.require_version ">= 1.9.0"

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.define "streisand-host", primary: true do |streisand|
    streisand.vm.hostname = "streisand-host"
    streisand.vm.network :private_network, ip: "10.0.0.10"

    streisand.vm.provision "ansible" do |ansible|
      # NOTE: Uncomment the below line for verbose Ansible output
      # ansible.verbose = "v"
      ansible.playbook = "playbooks/streisand.yml"
      ansible.host_vars = {
        "streisand-host" => {
          "noninteractive" => true
        }
      }
    end
  end
end
