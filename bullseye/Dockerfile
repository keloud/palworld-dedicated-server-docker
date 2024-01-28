###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="12002158+keloud@users.noreply.github.com"

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY etc/entry.sh "${HOMEDIR}/entry.sh"

RUN set -x \
    && mkdir -p "${STEAMAPPDIR}" \
    && chmod +x "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
    && chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

# Setup RCON Client
RUN wget -O rcon-cli.tar.gz https://github.com/gorcon/rcon-cli/releases/download/v0.10.3/rcon-0.10.3-amd64_linux.tar.gz
RUN tar -xzvf ./rcon-cli.tar.gz -C ./rcon-cli
RUN rm ./rcon-cli.tar.gz

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
# 8211/udp = game traffic
# 27015/udp = query traffic
# 25575/tcp = rcon traffic
EXPOSE 8211/udp \
    27015/udp \
    25575/tcp
