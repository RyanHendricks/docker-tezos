# Docker-Tezos

Dockerized Tezos Full Node (Bootstrapped)

---

[![MicroBadger Version](https://images.microbadger.com/badges/version/ryanhendricks/docker-tezos.svg)](https://microbadger.com/images/ryanhendricks/docker-tezos)
[![CircleCI (all branches)](https://img.shields.io/circleci/project/github/RyanHendricks/docker-tezos.svg?label=build&logo=circleci&logoColor=white)](https://circleci.com/gh/RyanHendricks/docker-tezos)
[![Docker Pulls](https://img.shields.io/docker/pulls/ryanhendricks/docker-tezos.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/ryanhendricks/docker-tezos)

[![MicroBadger Layers (latest)](https://img.shields.io/microbadger/layers/ryanhendricks/docker-tezos/latest.svg?logo=docker&logoColor=white)](https://microbadger.com/images/ryanhendricks/docker-tezos)
[![MicroBadger Image-Size (latest)](https://img.shields.io/microbadger/image-size/ryanhendricks/docker-tezos:latest.svg?logo=docker&logoColor=white)](https://microbadger.com/images/ryanhendricks/docker-tezos)

[![Codacy grade](https://img.shields.io/codacy/grade/c35da045d95b4f07b09948d19bacaa47.svg?logo=codacy)](https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=RyanHendricks/docker-tezos&amp;utm_campaign=Badge_Grade)

---

## Prerequisites

- Docker
- Docker-Compose (optional)

## Quick Start

The image can be run without any configuration and defaults to mainnet.

Before starting the node, the entrypoint script downloads and imports a snapshot (courtesy of [tzdutch.com](tzdutch.com)) which drastically reduces the time required to sync.

```bash
docker  run --rm -d -P ryanhendricks/docker-tezos:latest

# Feel free to use an alternate seed node although without one the node will have issues starting

```

## Configuration

### Config.toml Parameters

- The config.toml is created dynamically when starting the container.
- All parameters specified in the standard config.toml file can be set using environmental variables with the same as the config parameter but in all caps.
- If left unset the default values will be used.
- Parameters can be set directly by modifying the config.toml portion of ./scripts/entrypoint.sh if you are cloning and building the image yourself.



## Build

The following command will build the image.

```bash
docker build --rm -f Dockerfile -t docker-tezos:latest .
```

## Running

WIP

## Supervisor

The image uses Supervisor to run the tezos node at container runtime. Supervisor also restarts the node process should it fail for some reason.

## NOTES


## Contributing

[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?)](http://makeapullrequest.com)

### Contributors

[![Keybase PGP](https://img.shields.io/keybase/pgp/ryanhendricks.svg?label=keybase&logo=keybase&logoColor=white)](https://keybase.io/ryanhendricks)

## License

![GitHub](https://img.shields.io/github/license/ryanhendricks/docker-tezos.svg)
