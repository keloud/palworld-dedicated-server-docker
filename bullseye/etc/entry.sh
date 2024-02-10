#!/bin/bash
set -x

SERVER_PASSWORD=$(cat ${SERVER_PASSWORD_FILE})
ADMIN_PASSWORD=$(cat ${ADMIN_PASSWORD_FILE})

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" \
    +quit

if [ ! -s ${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini ]; then
    echo Generate PalWorldSettings.ini
    timeout --preserve-status 15s ${STEAMAPPDIR}/PalServer.sh
    sleep 5

    cp ${STEAMAPPDIR}/DefaultPalWorldSettings.ini ${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
fi

sed -i -e "s/RCONEnabled=[a-zA-Z]*/RCONEnabled=TRUE/g" \
    -e "s/RCONPort=\d*/RCONPort=${RCON_PORT}/g" \
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
