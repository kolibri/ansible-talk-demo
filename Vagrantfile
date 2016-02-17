# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [{
    :name => :ubuntu,
    :host => "ansible-demo-ubuntu.dev",
    :ip   => "192.168.31.42",
    :gui  => false,
    :box  => "ubuntu/trusty64"
},{
    :name => :arch,
    :host => "ansible-demo-arch.dev",
    :ip   => "192.168.31.44",
    :gui  => false,
    # box url: http://vogelschwarz.de/box/nest-arch.box
    :box  => "nest-arch"
},{
    :name => :osx,
    :host => "ansible-demo-osx.dev",
    :ip   => "192.168.31.43",
    :gui  => true,
    # box url: http://vogelschwarz.de/box/nest-osx.box
    :box  => "nest-osx"
}]

Vagrant.configure(2) do |config|
    boxes.each do |opts|
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.network "private_network", ip: opts[:ip]
            config.vm.host_name = opts[:host]
            #config.vm.synced_folder "./", "/home/vagrant/share", id: "vagrant-share", :nfs => true

            config.vm.provider :virtualbox do |virtualbox|
                virtualbox.gui = opts[:gui]
                virtualbox.customize ["modifyvm", :id, "--name", opts[:host]]
                virtualbox.customize ["modifyvm", :id, "--memory", "2048"]
                virtualbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                virtualbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
            end

        end
    end
end
