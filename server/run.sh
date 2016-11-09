#!/bin/sh

if [ ! -d /data ]; then
	echo "WARNING: did not find a data directory; booting without data and persistence!" >&2
	mkdir /data
fi

# prepare directories
echo "Preparing disk..."
rm -rf /etc/go
ln -s /data/config /etc/go

rmdir /var/lib/go-server
ln -s /data /var/lib/go-server

# prepare configuration
echo "Preparing configuration..."
mkdir -p /data/config
echo "export DAEMON=N" >> /etc/default/go-server
echo "export GO_SERVER_PORT=9153" >> /etc/default/go-server
echo "export GO_SERVER_SSL_PORT=9154" >> /etc/default/go-server
echo "export SERVER_MEM=\$(java-dynamic-memory-opts)" >> /etc/default/go-server
echo "export SERVER_MAX_MEM=\$(java-dynamic-memory-opts)" >> /etc/default/go-server

# prepare default runtime
[ ! -f /etc/go/log4j.properties ] && cp /log4j.properties /etc/go/log4j.properties

# enable custom extensions
mkdir -p /data/plugins/external
rm -f /data/plugins/external/github-oauth-login-1.2.jar
cp /*.jar /data/plugins/external

# ensuring perimssions
echo "Ensuring correct permissions for Go server..."
chown -R go /data

# extract deploment files
su go -c /extract-files.sh

# run Go as go user
echo "Starting actual Go server..."
su go -c /usr/share/go-server/server.sh
