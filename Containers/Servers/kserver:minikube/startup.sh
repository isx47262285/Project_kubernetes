#! /bin/bash
# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
# startup.sh
# -------------------------------------

/opt/docker/install.sh && echo "ok install"
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork

