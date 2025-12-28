#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt install update && apt install -y \
    build-essential libwrap0-dev \
    curl lynx vim sqlite3 w3m procps \
    python3 python3-html2text  \
    python3-requests python3-unidecode

# Backup the gopher directory in case something goes wrong
# tar -cvzf ~/gopher-backup.tar.gz /var/gopher

# Build Gophernicus
cp -r vendor/gophernicus_2.4 /opt/gophernicus_2.4
pushd /opt/gophernicus_2.4
make && make install && make clean-build
popd

# Copy application data
mkdir -p /opt/hngopher/data
touch /opt/hngopher/data/gopher-counter

mkdir -p /opt/hngopher/src
cp -R $DIR/src/* /opt/hngopher/src

cp $DIR/conf/gophernicus.env /etc/default/gophernicus

mkdir -p /var/gopher
cp -R $DIR/public/* /var/gopher/

# Initialize services
cp $DIR/conf/hn-archive.service /etc/systemd/system/
cp $DIR/conf/hn-archive.timer /etc/systemd/system/
cp $DIR/conf/hn-scrape.service /etc/systemd/system/
cp $DIR/conf/hn-scrape.timer /etc/systemd/system/

systemctl daemon-reload
systemctl enable --now hn-scrape.timer hn-archive.timer

# Rebuild the guestbook
/opt/hngopher/src/hn-guestbook.py dump

# Health check
curl gopher://localhost:7070
