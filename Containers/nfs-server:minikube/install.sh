#! /bin/bash
# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2018-2019
## Roberto Altamirano Martinez
# instalacion de nfs
# -------------------------------------
cp -ra  /opt/docker/nslcd.conf /etc/nslcd.conf
cp -ra /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp -ra /opt/docker/nsswitch.conf /etc/nsswitch.conf

mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/pau
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/jordi
mkdir /tmp/home/admin

cp README.md /tmp/home/pere
cp README.md /tmp/home/pau
cp README.md /tmp/home/anna
cp README.md /tmp/home/marta
cp README.md /tmp/home/jordi
cp README.md /tmp/home/admin
cp README.md /tmp/home/local01
cp README.md /tmp/home/local02

chown -R pere.users /tmp/home/pere
chown -R pau.users /tmp/home/pau
chown -R anna.alumnes /tmp/home/anna
chown -R marta.alumnes /tmp/home/marta
chown -R jordi.users /tmp/home/jordi
chown -R admin.wheel /tmp/home/admin
chown -R local01.users /tmp/home/local01
chown -R local02.users /tmp/home/local02


cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock
