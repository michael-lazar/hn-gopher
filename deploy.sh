DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt-get install -y python3 python3-requests python3-lxml python3-unidecode
apt-get instal -y libwrap0-dev
cp -R $DIR/hn-gopher/opt/gophernicus_* /opt/

pushd /opt/gophernicus_*
make
make install
make clean
popd

# Don't want to delete the archive/live folders
# rm -rf /var/gopher

cp -R $DIR/hn-gopher/var/gopher /var/gopher
cp -R $DIR/hn-gopher/bin/* /usr/local/bin/
cp -R $DIR/hn-gopher/etc/cron.d/* /etc/cron.d/

rm /etc/default/gophernicus
cp $DIR/hn-gopher/opt/gophernicus_*/gophernicus.env /etc/default/gophernicus
