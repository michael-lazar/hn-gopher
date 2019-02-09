#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt install -y curl lynx vim sqlite openssl
apt install -y python3 python3-pip python3-requests python3-lxml python3-unidecode
apt install -y libwrap0-dev
pip3 install html2text==2018.1.9
pip3 install gmail

# Backup the gopher directory in case something goes wrong
# tar -cvzf ~/gopher-backup.tar.gz /var/gopher

cp -R $DIR/hn-gopher/var/gopher/* /var/gopher/
cp -R $DIR/hn-gopher/bin/* /usr/local/bin/
cp -R $DIR/hn-gopher/etc/cron.d/* /etc/cron.d/
cp -R $DIR/hn-gopher/opt/gophernicus_* /opt/

mkdir -p /var/lib/hngopher
chmod 777 /var/lib/hngopher

pushd /opt/gophernicus_*
make && make install && make clean-build
popd

rm -f /etc/default/gophernicus
cp $DIR/hn-gopher/opt/gophernicus_*/gophernicus.env /etc/default/gophernicus

touch /var/tmp/gopher-counter
chmod 666 /var/tmp/gopher-counter

/usr/local/bin/hn-guestbook dump
chmod a+w /var/gopher/guestbook/gophermap
chmod a+w /var/lib/hngopher/hngopher.db

# Setup DNS discovery if serving from a dynamic IP address
# apt install -y ddclient
