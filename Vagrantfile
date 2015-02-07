# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # box
  config.vm.box = "ubuntu14.04"
  
  # define the vbox name
  config.vm.provider :virtualbox do |vb|
    vb.name = "cyclesafe"
    vb.memory = 1024
  end
  config.vm.define "cyclesafe" do |t|
  end

  # vm hostname
  config.vm.hostname = 'cyclesafe.com'

  # Enable Berkshelf
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "Berksfile"

  # control chef version
  config.omnibus.chef_version = '11.16.4'

  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # synched folder
  config.vm.synced_folder 'CycleSafe_deploy', '/srv/cyclesafe/releases/local'

  config.vm.provision :chef_solo do |chef|
    chef.custom_config_path = "Vagrantfile.chef"
    
    #chef.roles_path = "roles"
    chef.data_bags_path = "data_bags"
    chef.node_name = "cyclesafe.com"
    chef.add_recipe "chef-solo-search"
    chef.add_recipe "cyclesafe_chef::database"
    chef.add_recipe "cyclesafe_chef::application"
    chef.add_recipe "cyclesafe_chef::sysadmins"

    # assert revision
    chef.json = {
      "cyclesafe_chef" => {
        "repository" => "/srv/cyclesafe/releases/local",
        "revision" => "master"
      },
      "instance_role" => "vagrant"
    }
  end
end
