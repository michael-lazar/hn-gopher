# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_COMMAND = ARGV[0]

Vagrant.configure(2) do |config|

  config.vm.box = "debian/jessie64"

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provision "shell", inline: <<-SHELL

    # Setup the system
    timedatectl set-timezone UTC
    apt-get install -y curl lynx vim
    apt-get install -y python3 python3-requests

    # Install build dependencies
    apt-get install -y libwrap0-dev

    # Build and install the gopher server
    cp -R /vagrant/hn-gopher/opt/gophernicus_* /opt/
    cd /opt/gophernicus_*
    make
    make install
    make clean-build

    # Create symlinks to the data files for easy development
    rm -rf /var/gopher
    ln -s /vagrant/hn-gopher/var/gopher /var/gopher
    ln -s /vagrant/hn-gopher/bin/* /usr/local/bin
    ln -s /vagrant/hn-gopher/etc/cron.d/hngopher /etc/cron.d/hngopher

    rm -f /etc/default/gophernicus
    ln -s /vagrant/hn-gopher/opt/gophernicus_*/gophernicus.env /etc/default/gophernicus

    # Test the server
    echo -e "127.0.0.1\thngopher.com" >> /etc/hosts
    curl gopher://hngopher.com

  SHELL

end
