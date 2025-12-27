FROM debian:trixie

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential libwrap0-dev \
    curl lynx vim sqlite3 w3m procps \
    python3 python3-html2text  \
    python3-requests python3-unidecode \
    && rm -rf /var/lib/apt/lists/*

# Build Gophernicus
COPY vendor/gophernicus_2.4 /opt/gophernicus_2.4
WORKDIR /opt/gophernicus_2.4
RUN make && make install && make clean-build

# Configure Gophernicus
COPY gophernicus.env /etc/default/gophernicus

# Setup directories
RUN mkdir -p /var/gopher /opt/hngopher /var/log/gophernicus

WORKDIR /opt/hngopher
