#! /bin/bash
# @edt ASIX M06 2018-2019
# startup.sh
# -------------------------------------
/opt/docker/install.sh && echo "Install Ok"

/usr/sbin/smbd  && echo "smb Ok"
/usr/sbin/nmbd  && echo "nmb  Ok"

i=1
while [[ i -lt 10 ]]
do
  x=1
done 
