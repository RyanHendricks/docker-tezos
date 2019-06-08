#!/bin/sh

# exit script on any error
set -e

# rm /root/.tezos-node/identity.json
# tezos-node identity generate 1
# tezos-node upgrade storage

wget http://quicksync.tzdutch.com/mainnet-BMKkyoQRCUHh2nLxZE4o6q3ExQDeGntNsdMKTbzq6gEXRg6HguV.full.tar.lz4
lz4 -d mainnet-BMKkyoQRCUHh2nLxZE4o6q3ExQDeGntNsdMKTbzq6gEXRg6HguV.full.tar.lz4 | tar xf -

mkdir -p /root/.tezos-node
cp /bootstrap/version.json /root/.tezos-node/version.json
cp /bootstrap/identity.json /root/.tezos-node/identity.json

tezos-node snapshot import mainnet-BMKkyoQRCUHh2nLxZE4o6q3ExQDeGntNsdMKTbzq6gEXRg6HguV.full

# cp /bootstrap/version.json /root/.tezos-node/version.json
# cp /bootstrap/identity.json /root/.tezos-node//identity.json

# tezos-node run --history-mode full --rpc-addr 0.0.0.0:8732

exec supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf