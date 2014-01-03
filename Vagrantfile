# -*- mode: ruby -*-
# vi: set ft=ruby :

# General configuration
#######################
ip_address = '33.33.33.10'
project_name = 'myAwesomeProject'
src_path = '/public/'
database_password = 'root'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	# All Vagrant configuration is done here. The most common configuration
	# options are documented and commented below. For a complete reference,
	# please see the online documentation at vagrantup.com.

	# Every Vagrant virtual environment requires a box to build off of.
	config.vm.box = "precise32"
	config.vm.box_url = "http://files.vagrantup.com/precise32.box"

	# Enable Berkshelf support
	config.berkshelf.enabled = true

	# make sure omnibus is up to date
	config.omnibus.chef_version = :latest

	# set the name of the vm in virtualbox
	config.vm.provider :virtualbox do |vb|
		vb.name = "Vagrant-"+ project_name
	end
	config.vm.boot_timeout = 120

	# set the shared folder
	config.vm.synced_folder "./public/" , src_path, :mount_options => ["dmode=777", "fmode=666"]

	# Manage the adress and hostname of the VM
	config.vm.network :private_network, ip: ip_address
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.vm.define project_name do |node|
		node.vm.hostname = project_name + ".dev"
		node.vm.network :private_network, ip: ip_address
		node.hostmanager.aliases = [ "www." + project_name + ".dev" ]
	end
	config.vm.provision :hostmanager

	# Enable and configure chef solo
	config.vm.provision :chef_solo do |chef|
		chef.add_recipe "app::node"
		chef.add_recipe "app::database"

		chef.json = {
			:mysql => {
				:server_root_password   => database_password,
				:server_repl_password   => database_password,
				:server_debian_password => database_password,
				:bind_address           => ip_address,
				:allow_remote_root      => true
			}
		}
	end

end