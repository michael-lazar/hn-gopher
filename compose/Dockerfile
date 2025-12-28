FROM debian:trixie

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential libwrap0-dev \
    curl lynx vim sqlite3 w3m procps \
    python3 python3-html2text  \
    python3-requests python3-unidecode

# Install dev dependencies
RUN apt-get install -y xinetd

# Build Gophernicus
COPY vendor/gophernicus_2.4 /opt/gophernicus_2.4
WORKDIR /opt/gophernicus_2.4
RUN make && make install && make clean-build

# Setup directories
RUN mkdir -p /var/gopher /opt/hngopher /var/log/gophernicus

# Copy configuration
COPY conf/gophernicus.env /etc/default/gophernicus
COPY compose/conf/gopher.xinetd /etc/xinetd.d/gopher
COPY compose/conf/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /opt/hngopher

# Expose gopher port
EXPOSE 70

# Start using entrypoint script
CMD ["/usr/local/bin/docker-entrypoint.sh"]
