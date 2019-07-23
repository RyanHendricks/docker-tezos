# Docker-Tezos

Dockerized Tezos Node
Full or Archive History Mode
Optional Bootstrapping for Full Node

---

[![MicroBadger Version](https://images.microbadger.com/badges/version/ryanhendricks/docker-tezos.svg)](https://microbadger.com/images/ryanhendricks/docker-tezos)
[![CircleCI (all branches)](https://img.shields.io/circleci/project/github/RyanHendricks/docker-tezos.svg?label=build&logo=circleci&logoColor=white)](https://circleci.com/gh/RyanHendricks/docker-tezos)
[![Docker Pulls](https://img.shields.io/docker/pulls/ryanhendricks/docker-tezos.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/ryanhendricks/docker-tezos)

[![MicroBadger Layers (latest)](https://img.shields.io/microbadger/layers/ryanhendricks/docker-tezos/latest.svg?logo=docker&logoColor=white)](https://microbadger.com/images/ryanhendricks/docker-tezos)
[![MicroBadger Image-Size (latest)](https://img.shields.io/microbadger/image-size/ryanhendricks/docker-tezos:latest.svg?logo=docker&logoColor=white)](https://microbadger.com/images/ryanhendricks/docker-tezos)

[![Codacy grade](https://img.shields.io/codacy/grade/c35da045d95b4f07b09948d19bacaa47.svg?logo=codacy)](https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=RyanHendricks/docker-tezos&amp;utm_campaign=Badge_Grade)

---

## Configuration

Simply build and run the container specifying the following ENV variables with the desired ~~options~~

BOOTSTRAP
  - TRUE
  - FALSE
NODE_TYPE
  - full
  - archive

## Background

Before starting the tezos-node, the entrypoint script downloads and imports a snapshot (only if BOOTSTRAP=TRUE) which drastically reduces the time required to sync. (If you have an alternate snapshot that is preferred you can simply change the url in the entrypoint.sh script).

Additionally, there is only one container created whereas running the Tezos official script creates more than a few.

## Prerequisites

- Docker

## Quick Start

The image can be run without any configuration and defaults to mainnet.

```bash

docker  run --rm -d -P ryanhendricks/docker-tezos:latest

```

## Supervisor

The image uses Supervisor to run the tezos node at container runtime. Supervisor also restarts the tezos-node process should it fail for some reason.

## Configuration

The built in configuration implemented at runtime by the supervisor process is as follows:

```sh

tezos-node run --history-mode full --rpc-addr 0.0.0.0:8732 --cors-header='content-type' --cors-origin='*'

```

Modifications can be made by simply changing the start command in the [./supervisor/conf.d/supervisor-tezos.conf](./supervisor/conf.d/supervisor-tezos.conf) file.

## Build

The following command will build the image.

```bash
docker build --rm -f Dockerfile -t docker-tezos:latest .
```

## Running

### Standalone Docker

```bash
# This assumes you built the image with the tag docker-tezos:latest
docker  run --rm -d -P docker-tezos:latest

```

## NOTES

At this time, if the process (tezos-node) fails it will be restarted without requiring the container to be restarted. Persistent storage mount implemented and restarting node does not restart the syncing process

## Issues

Questions, issues, deployment troubles, suggestions, etc., are all welcomed.

## Contributing

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?)](http://makeapullrequest.com)

### Contributors

[![Keybase PGP](https://img.shields.io/keybase/pgp/ryanhendricks.svg?label=keybase&logo=keybase&logoColor=white)](https://keybase.io/ryanhendricks)

## License

![GitHub](https://img.shields.io/github/license/ryanhendricks/docker-tezos.svg)
