# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "kalilinux/rolling"
  config.vm.synced_folder "./shared", "/home/vagrant/shared"

  # Setup SSH keys correctly
  config.ssh.insert_key = false
  config.ssh.private_key_path = ["~/.ssh/id_ed25519", "~/.vagrant.d/insecure_private_key"]
  config.vm.provision "file", source: "~/.ssh/id_ed25519.pub", destination: "~/.ssh/authorized_keys"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  # disable guest addition plugin update
  if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.auto_update = false
  end

  # Create a forwarded port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network. In VirtualBox, this is a Host-Only network
  # config.vm.network "private_network", ip: "192.168.33.10"

  # VirtualBox-specific configurations
  config.vm.provider "virtualbox" do |vb|
    # Set the box name
    vb.name = "kali"
  
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Set custom monitor count
    # vb.customize ["modifyvm", :id, "--monitorcount", "2"]

    # Customize the amount of memory to 4GB or 8GB on the VM:
    # vb.memory = 4096
    vb.memory = 8192
    # Customize the number of cpus to 2 on the VM:
    vb.cpus = 2

    # use max 80% of the cpu
    # removed the cpuexecutioncap, because VirtualBox complains about iz
    # vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]

    # enable USB
    # vb.customize ["modifyvm", :id, "--usb", "on"]       # enable USB 1.x
    # vb.customize ["modifyvm", :id, "--usbehci", "on"]   # enable USB 2.x
    # vb.customize ["modifyvm", :id, "--usbxhci", "on"]   # enable USB 3.x
  end

  # Provision the machine with Ansible
  config.vm.provision "ansible_local" do |ansible|
      ansible.install = true
      # set compatibility mode to ansible 2.0 to mute warnings:
      ansible.compatibility_mode = "2.0"
      ansible.playbook = "playbook.yml"
      # ansible.verbose = true
      ansible.verbose = false
      ansible.limit = "all"
      ansible.become = true
      ansible.raw_arguments = [ '-e', 'ansible_python_interpreter=/usr/bin/python' ]
      ansible.config_file = "ansible.cfg"
      ansible.become_user = "vagrant"
  end
end
