#!/bin/bash
set -e

# Tail the log file to stdout in the background
touch /var/log/gophernicus/server.log
tail -f /var/log/gophernicus/server.log &

# Start xinetd in the foreground
exec /usr/sbin/xinetd -dontfork