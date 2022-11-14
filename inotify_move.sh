#!/bin/bash
if [ ! -d $1 ] ; then echo please supply folder to move from ; exit 1 ; fi
if [ ! -d $2 ] ; then echo please supply folder to move to   ; exit 2 ; fi
shopt -s extglob
from=${1%%+(/)}
to=${2%%+(/)}
if [ "$(stat -c "%d:%i" ${from})" == "$(stat -c "%d:%i" ${to})" ] ; then echo source and destination are the same; exit 3; fi
set -x
inotifywait -m -e close -r --format "%f" $from | while read filename; do
s="${from}/${filename}"
if [ -d ${s} ] ; then continue ; fi
[ -s ${s} ] || continue
if [[ ${filename} = *virtual* ]] ; then continue ; fi
if [[ ${filename} = *master* ]] ; then continue ; fi
if [ -f ${s} ] ; then
chown opid09 ${s}
su -c "mv "${s}" \""${to}"/"${filename}"\"" opid09
fi;
done
