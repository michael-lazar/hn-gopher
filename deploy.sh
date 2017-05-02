DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt-get install -y python3 python-requests
apt-get instal -y libwrap0-dev
cp -R $DIR/hn-gopher/opt/gophernicus_* /opt/

pushd /opt/gophernicus_*
make
make install
make clean
popd

rm -rf /var/gopher
cp -R $DIR/hn-gopher/var/gopher /var/gopher
cp -R $DIR/hn-gopher/bin/* /usr/local/bin/
