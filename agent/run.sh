#!/bin/sh

# setup docker socket permissions for go-agent
chown :go /var/run/docker.sock

# prepare agent directories
mkdir -p /var/lib/go-agent/config
chown -R go:go /var/lib/go-agent
chown -R go:go /var/go

# setup auto registration
echo "agent.auto.register.key=$STUPS_GO_AGENT_REGISTRATION_KEY" >> /var/lib/go-agent/config/autoregister.properties
echo "agent.auto.register.environments=$STUPS_GO_AGENT_ENVIRONMENTS" >> /var/lib/go-agent/config/autoregister.properties
echo "agent.auto.register.resources=$STUPS_GO_AGENT_RESOURCES" >> /var/lib/go-agent/config/autoregister.properties

# extract deploment files
su go -c /extract-files.sh

# for local development:
if [ ! -z "$GO_SERVER_LINK_PORT_9153_TCP_ADDR" ]; then
	export STUPS_GO_SERVER_DOMAIN=$GO_SERVER_LINK_PORT_9153_TCP_ADDR
fi

# run the agent
su go -c "/usr/share/go-agent/agent.sh go-agent"
