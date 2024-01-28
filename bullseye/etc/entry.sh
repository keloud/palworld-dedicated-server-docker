#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
    +login anonymous \
    +app_update "${STEAMAPPID}" \
    +quit

# Setup RCON Client
sed -i -e "s/address\:\ \"\"/${RCON_PORT}/g" \
    -e "s/password\:\ \"\"/${ADMIN_PASSWORD}/g" "${HOMEDIR}/rcon-cli/rcon.yaml"

if [ ! -s ${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini ]; then
    cp ${STEAMAPPDIR}/DefaultPalWorldSettings.ini ${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini
fi

sed -i -e "s/RCONEnabled=[a-zA-Z]*/RCONEnabled=TRUE/g" \
    -e "s/RCONPort=[0-9]*/RCONPort=${RCON_PORT}/g" "${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"

bash "${STEAMAPPDIR}/PalServer.sh" \
    -port=${PORT} \
    -queryport=${QUERY_PORT} \
    -serverpassword=${SERVER_PASSWORD} \
    -adminpassword=${ADMIN_PASSWORD} \
    -servername=${SERVER_NAME} \
    -serverdescription=${SERVER_DESCRIPTION} \
    -useperfthreads \
    -NoAsyncLoadingThread \
    -UseMultithreadForDS
    
    
