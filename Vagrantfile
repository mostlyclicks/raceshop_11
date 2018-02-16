# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  # config.vm.network "forwarded_port", guest: 5432, host: 5432
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/mostlyclicks/vagrant_provision_rails5/master/provision.sh"
  # config.vm.provision "shell", path: "provision.sh"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1536"]
  end
end