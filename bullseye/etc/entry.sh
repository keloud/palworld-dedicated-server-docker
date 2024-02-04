#!/bin/bash
set -x

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" \
    +quit

if [ ! -d ${HOMEDIR}/rcon-cli ]; then
    echo Setup RCON Client
    curl -OL https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
    mkdir -v ${HOMEDIR}/rcon-cli
    tar -xzvf rcon-0.10.3-amd64_linux.tar.gz -C ${HOMEDIR}/rcon-cli --strip-components 1
    rm -v rcon-0.10.3-amd64_linux.tar.gz
fi
sed -i -e "s/address: [a-zA-Z0-9:\"]*/address: "127.0.0.1:${RCON_PORT}"/g" \
    -e "s/password: [a-zA-Z0-9:\"]*/password: ${ADMIN_PASSWORD}/g" "${HOMEDIR}/rcon-cli/rcon.yaml"

if [ ! -s ${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini ]; then
    echo Generate PalWorldSettings.ini
    timeout --preserve-status 15s ${STEAMAPPDIR}/PalServer.sh 1> /dev/null
    sleep 5

    cp ${STEAMAPPDIR}/DefaultPalWorldSettings.ini ${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
fi

sed -i -e "s/RCONEnabled=[a-zA-Z]*/RCONEnabled=TRUE/g" \
    -e "s/RCONPort=[0-9]*/RCONPort=${RCON_PORT}/g" \
    "${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"

bash "${STEAMAPPDIR}/PalServer.sh" \
    -port=${PORT} \
    -queryport=${QUERY_PORT} \
    -serverpassword=${SERVER_PASSWORD} \
    -adminpassword=${ADMIN_PASSWORD} \
    -servername=${SERVER_NAME} \
    -serverdescription=${SERVER_DESCRIPTION} \
    -players=${MAXPLAYERS} \
    -useperfthreads \
    -NoAsyncLoadingThread \
    -UseMultithreadForDS
