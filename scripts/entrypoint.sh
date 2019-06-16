#!/bin/sh

# exit script on any error
set -e

wget http://quicksync.tzdutch.com/mainnet-BMKkyoQRCUHh2nLxZE4o6q3ExQDeGntNsdMKTbzq6gEXRg6HguV.full.tar.lz4
lz4 -d mainnet-BMKkyoQRCUHh2nLxZE4o6q3ExQDeGntNsdMKTbzq6gEXRg6HguV.full.tar.lz4 | tar xf -

mkdir -p /root/.tezos-node
cp /bootstrap/version.json /root/.tezos-node/version.json
cp /bootstrap/identity.json /root/.tezos-node/identity.json

tezos-node snapshot import mainnet-BMKkyoQRCUHh2nLxZE4o6q3ExQDeGntNsdMKTbzq6gEXRg6HguV.full

exec supervisord --nodaemon --configuration /etc/supervisor/supervisord.conf