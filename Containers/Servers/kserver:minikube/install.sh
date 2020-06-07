#! /bin/bash
# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
## Instalacion de Kerberos
# -------------------------------------
cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /opt/docker/kadm5.acl  /var/kerberos/krb5kdc/kadm5.acl

kdb5_util create -s -P masterkey
kadmin.local -q "addprinc -pw anna anna"
kadmin.local -q "addprinc -pw pere pere"
kadmin.local -q "addprinc -pw pau pau"
kadmin.local -q "addprinc -pw jordi jordi"
kadmin.local -q "addprinc -pw marta marta"
kadmin.local -q "addprinc -pw marta marta/admin"
kadmin.local -q "addprinc -pw julia julia"
kadmin.local -q "addprinc -pw superuser superuser"
kadmin.local -q "addprinc -pw local01 local01"
kadmin.local -q "addprinc -pw local02 local02"
kadmin.local -q "addprinc -pw user01 user01"
kadmin.local -q "addprinc -pw user02 user02"
kadmin.local -q "addprinc -pw user03 user03"
kadmin.local -q "addprinc -randkey host/sshd.edt.org"

