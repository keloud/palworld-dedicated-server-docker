#!/bin/bash
set -x

SERVER_PASSWORD=$(cat ${SERVER_PASSWORD_FILE})
ADMIN_PASSWORD=$(cat ${ADMIN_PASSWORD_FILE})

if [ ! -d ${HOMEDIR}/rcon-cli ]; then
    echo Setup RCON Client
    curl -OL https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
    mkdir -v ${HOMEDIR}/rcon-cli
    tar -xzvf rcon-0.10.3-amd64_linux.tar.gz -C ${HOMEDIR}/rcon-cli --strip-components 1
    rm -v rcon-0.10.3-amd64_linux.tar.gz
fi
sed -i -e "s/address: .* /address: "127.0.0.1:${RCON_PORT}" /g" \
    -e "s/password: .*/password: ${ADMIN_PASSWORD} /g" "${HOMEDIR}/rcon-cli/rcon.yaml"
