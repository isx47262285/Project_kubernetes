#! /bin/bash
# instalacion y arranque en background
# -------------------------------------

/opt/docker/install.sh && echo "Install Ok"
/sbin/slapd -d0  && echo "slapd Ok"

