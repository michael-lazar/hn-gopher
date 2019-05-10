# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_COMMAND = ARGV[0]

Vagrant.configure(2) do |config|

  config.vm.box = "debian/jessie64"

  config.vm.synced_folder(
  	".",
  	"/vagrant",
  	:nfs => { :mount_options => ["dmode=777","fmode=777"] }
  	)
  config.vm.network "forwarded_port", guest: 70, host: 70
  config.vm.network "private_network", type: "dhcp"

  config.vm.provision "shell", inline: <<-SHELL

    # Setup the system
    timedatectl set-timezone UTC
    apt install -y build-essential
    apt install -y curl lynx vim sqlite
    apt install -y python3 python3-pip python3-requests python3-lxml python3-unidecode

    pip3 install html2text==2018.1.9

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

    # Setup the directory where the database is stored
    mkdir -p /var/lib/hngopher
    chmod 777 /var/lib/hngopher

    rm -f /etc/default/gophernicus
    ln -s /vagrant/hn-gopher/opt/gophernicus_*/gophernicus.env /etc/default/gophernicus

    /usr/local/bin/hn-guestbook dump
    chmod a+w /var/gopher/guestbook/gophermap
    chmod a+w /var/lib/hngopher/hngopher.db

    # Test the server
    echo -e "127.0.0.1\thngopher.com" >> /etc/hosts
    curl gopher://hngopher.com

  SHELL

end
