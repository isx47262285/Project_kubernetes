#! /bin/bash
/opt/docker/install.sh && echo "ok install"
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork

