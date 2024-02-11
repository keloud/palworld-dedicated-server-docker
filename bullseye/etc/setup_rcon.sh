#!/bin/bash
set -x

# Setup RCON Client
curl -OL https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
mkdir -v ${RCONDIR}
tar -xzvf rcon-0.10.3-amd64_linux.tar.gz -C ${RCONDIR} --strip-components 1
chown -R "${USER}:${USER}" "${RCONDIR}"
rm -v rcon-0.10.3-amd64_linux.tar.gz
