#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt-get install -y curl lynx vim
apt-get install -y python3 python3-requests python3-lxml python3-unidecode
apt-get install -y libwrap0-dev

cp -R $DIR/hn-gopher/var/* /var/
cp -R $DIR/hn-gopher/bin/* /usr/local/bin/
cp -R $DIR/hn-gopher/etc/cron.d/* /etc/cron.d/
cp -R $DIR/hn-gopher/opt/gophernicus_* /opt/

pushd /opt/gophernicus_*
make && make install && make clean-build
popd

rm -f /etc/default/gophernicus
cp $DIR/hn-gopher/opt/gophernicus_*/gophernicus.env /etc/default/gophernicus
