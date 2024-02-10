#!/bin/bash
set -x

if [ ! -d ${BACKUPDIR} ]; then
  echo ${BACKUPDIR} does not exits
  return 1
fi

if [ -f ${BACKUPDIR}/.latest_backup_date ]; then
  OLDDATE=$(cat ${BACKUPDIR}/.latest_backup_date)
fi
OLDDATE=${OLDDATE:="NOT_SET"}
NEWDATE=$(date +%Y%m%d-%H%M)

OLDBACKUPDIR=${BACKUPDIR}/${OLDDATE}
NEWBACKUPDIR=${BACKUPDIR}/${NEWDATE}

if [ "${OLDDATE}" = "${NEWDATE}" ]; then
  echo "Already backed up"
  exit 0
fi

tar -czvf ${BACKUPDIR}/${NEWDATE}.tar.gz -C ${STEAMAPPDIR}/Pal/ Saved

cat {NEWDATE} > ${BACKUPDIR}/.latest_backup_date
