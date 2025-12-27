#!/bin/sh

##
## A simple visitor counter to use with gophermaps
##
## Usage: counter.sh <pre message> <post message>
##

# Figure out a safe file to keep our counter
FILE=/var/tmp/gopher-counter

# Get count and the previous visitors IP address
COUNT="`cut -d' ' -f1 $FILE`"
OLD_ADDR="`cut -d' ' -f2 $FILE`"

# Increase counter only if the user is new
if [ "$OLD_ADDR" != "$REMOTE_ADDR" ]; then
	COUNT=$(( COUNT + 1 ))
	echo "$COUNT $REMOTE_ADDR" > $FILE
fi

# Output counter message
echo "$1$COUNT$2"

