# Create box by vagrant up && vagrant reload

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
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 8180, host: 8180
  config.vm.network "forwarded_port", guest: 8181, host: 8181

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.2.4"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
   # Display the VirtualBox GUI when booting the machine
   vb.gui = true
    #   # Customize the amount of memory on the VM:
   vb.memory = "4096"

   # Install xfce and virtualbox additions

   # Set default password
   config.vm.provision "shell", inline: "echo ubuntu:ubuntuPW | sudo chpasswd "

   config.vm.provision "shell", inline: "sudo apt-get update"

   # Install XFCE4 as window system with lightdm and auto-login and gnome-terminal
   config.vm.provision "shell", inline: "sudo apt-get -y install xfce4"
   config.vm.provision "shell", inline: "sudo apt-get -y install lightdm"
   config.vm.provision "shell", inline: "sudo echo -e \"[SeatDefaults]\nuser-session=xfce\nautologin-user=ubuntu\nautologin-user-timeout=0\nautologin-session=xfce\n\" > /etc/lightdm/lightdm.conf.d/50-xfce4.conf"
   config.vm.provision "shell", inline: "sudo apt-get -y install gnome-terminal"

   # Default keyboard layout German
   config.vm.provision "shell", inline: "grep -q -F 'setxkbmap de' /home/ubuntu/.profile || echo 'setxkbmap de' >> /home/ubuntu/.profile"

   # Target-Agent build packages
   config.vm.provision "shell", inline: "sudo apt-get -y install autoconf automake libtool eclipse-cdt cmake-qt-gui build-essential git gdb"

   # Client/Server infrastructure for Musicplayer Application
   config.vm.provision "shell", inline: "sudo apt-get -y install nodejs npm nodejs-legacy firefox gedit"

   #config.vm.provision "shell", inline: "sudo git clone https://github.com/torsten-systemticks/franca-musicplayer-example ."
   config.vm.provision :shell, path: "install.sh"
	  
  end

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
