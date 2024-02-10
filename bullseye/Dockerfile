###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="12002158+keloud@users.noreply.github.com"

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV BACKUPDIR "${HOMEDIR}/${STEAMAPP}-dedicated-backup"

COPY etc/entry.sh ${HOMEDIR}
COPY etc/setup_rcon.sh ${HOMEDIR}
COPY etc/backup.sh ${HOMEDIR}

RUN set -x
RUN mkdir -p "${STEAMAPPDIR}"
RUN mkdir -p "${BACKUPDIR}"
RUN chmod +x "${HOMEDIR}/entry.sh" "${HOMEDIR}/setup_rcon.sh" "${HOMEDIR}/backup.sh" "${STEAMAPPDIR}"
RUN "${HOMEDIR}/setup_rcon.sh"
RUN chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${HOMEDIR}/setup_rcon.sh" "${HOMEDIR}/backup.sh" "${STEAMAPPDIR}" "${BACKUPDIR}"

FROM build_stage AS bullseye-base

ENV PORT=8211
ENV QUERY_PORT=27015
ENV RCON_PORT=25575
ENV MAXPLAYERS=30
ENV SERVER_PASSWORD_FILE=/run/secrets/server_password
ENV ADMIN_PASSWORD_FILE=/run/secrets/admin_password
ENV SERVER_NAME="Palworld Dedicated Server"
ENV SERVER_DESCRIPTION=""

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE ${PORT}/udp
EXPOSE ${QUERY_PORT}/udp
EXPOSE ${RCON_PORT}/tcp
