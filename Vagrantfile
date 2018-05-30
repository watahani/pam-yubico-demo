# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "bento/centos-7.3"
  
  config.vbguest.auto_update = false
  
  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     vb.gui = true
  
     # Customize the amount of memory on the VM:
     vb.memory = "1024"
  end
  
  # Enable USB Controller on VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "on"]
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y update
    sudo yum -y upgrade
    echo "system updated ..."    
  SHELL
  
  config.vm.provision "shell", :path => "./setup_pam_yubico.sh", :privileged => true
  config.vm.provision "shell", :path => "./setup_gnome.sh", :privileged => true

  config.vm.provider "virtualbox" do |vb|
    vb.customize [
        "usbfilter", "add", "0",
        "--name", "YubiKey Series",
        "--target", :id,
        "--vendorid", 1050,
        "--manufacturer", "Yubico"
    ]
  end
end
