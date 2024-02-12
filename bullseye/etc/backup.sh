#!/bin/bash
set -x

if [ ! -d ${BACKUPDIR} ]; then
  echo ${BACKUPDIR} does not exits
  mkdir -v ${BACKUPDIR}
fi

if [ ! -d ${RCONDIR} ]; then
  echo ${RCONDIR} does not exits
  exit 1
fi

# Save
${RCONDIR}/rcon -c "${RCONDIR}/rcon.yaml" save

# Get latest backup date
if [ -f ${BACKUPDIR}/.latest_backup_date ]; then
  OLDDATE=$(cat ${BACKUPDIR}/.latest_backup_date)
else
  touch ${BACKUPDIR}/.latest_backup_date
fi
OLDDATE=${OLDDATE:="NOT_SET"}

# Get date
NEWDATE=$(date +%Y%m%d-%H%M)

if [ "${OLDDATE}" = "${NEWDATE}" ]; then
  echo "Already backed up"
  exit 0
fi

tar -czvf ${BACKUPDIR}/${NEWDATE}.tar.gz -C ${STEAMAPPDIR}/Pal/ Saved

cat ${NEWDATE} > ${BACKUPDIR}/.latest_backup_date
