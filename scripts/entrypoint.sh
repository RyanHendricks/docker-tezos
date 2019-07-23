#!/bin/sh

# exit script on any error
set -e

# Create tezos data directory if it does not exist for some reason
if [ ! -d "/root/tezos-data" ]; then
  echo "Creating directory for Tezos data"
  mkdir -p /root/tezos-data
fi

# Check if chain data is present before bootstrapping
if [ ! -d "/root/tezos-data/context" ]; then

# Bootstrap node if env var is set to TRUE
  if [ "$BOOTSTRAP" == "TRUE" ]; then
    echo "Bootstrapping Tezos Node"
    mkdir -p /tmp/bootstrap
    cd /tmp/bootstrap
    wget https://storage.googleapis.com/node-bootstraps/tezos/mainnet.full.tar.lz4
    lz4 -d -v --rm mainnet.full.tar.lz4 | tar xf -

    echo "Importing snapshot. This will take some time..."
    tezos-node snapshot import mainnet.full --data-dir /root/tezos-data

    echo "Cleaning up..."
    cd /root/tezos-data
    rm -r /tmp/bootstrap
  fi
fi


if [ ! -f "/root/tezos-data/config.json" ]; then
  echo "Creating Tezos configuration"
  tezos-node config init --data-dir /root/tezos-data
  tezos-node config update --data-dir /root/tezos-data
fi

if [ ! -f "/root/tezos-data/identity.json" ]; then
  echo "No identity file found, generating new identity for Tezos node"
  tezos-node identity generate
  cp /root/.tezos-node/identity.json /root/tezos-data/identity.json
  rm /root/.tezos-node/identity.json
fi

if [ ! -f "/root/tezos-data/version.json" ]; then
  cp /root/.tezos-node/version.json /root/tezos-data/version.json
  rm /root/.tezos-node/version.json
fi

# The following line can be used to start the node without using supervisord
# exec tezos-node run --data-dir=/root/tezos-data --history-mode full --rpc-addr 0.0.0.0:8732 --cors-header='content-type' --cors-origin='*'
if [ "$NODE_TYPE" = "archive" ]; then

  echo "Configuring node history mode as archive"
  rm /etc/supervisor/conf.d/supervisor-tezos.conf
  cd /etc/supervisor/conf.d/

cat > supervisor-tezos.conf << EOF
[program:tezos-node]
command=tezos-node run --data-dir /root/tezos-data --history-mode ${NODE_TYPE:-archive} --rpc-addr 0.0.0.0:8732 --cors-header='content-type' --cors-origin='*'
redirect_stderr=true
EOF

  cd /root/tezos-data

fi

# Start supervisor process manager
echo "Starting Tezos Node via Supervisor Process Manager"
exec supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf