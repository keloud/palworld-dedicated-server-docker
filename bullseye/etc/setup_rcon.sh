#!/bin/bash
set -x

echo Setup RCON Client
curl -OL https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
mkdir -v ${HOMEDIR}/rcon-cli
tar -xzvf rcon-0.10.3-amd64_linux.tar.gz -C ${HOMEDIR}/rcon-cli --strip-components 1
rm -v rcon-0.10.3-amd64_linux.tar.gz
