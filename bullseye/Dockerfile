###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="12002158+keloud@users.noreply.github.com"

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY etc/entry.sh ${HOMEDIR}

RUN set -x
RUN mkdir -p "${STEAMAPPDIR}"
RUN chmod +x "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"
RUN chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

FROM build_stage AS bullseye-base

ENV PORT=8211 \
    QUERY_PORT=27015 \
    RCON_PORT=25575 \
    MAXPLAYERS=10 \
    SERVER_PASSWORD="" \
    ADMIN_PASSWORD="changeme" \
    SERVER_NAME="Palworld Dedicated Server" \
    SERVER_DESCRIPTION=""

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE ${PORT}/udp \
    ${QUERY_PORT}/udp \
    ${RCON_PORT}/tcp
