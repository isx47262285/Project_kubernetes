# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano
#  NFS SERVER
# -------------------------------------
FROM fedora:27
LABEL author="Roberto Altamirano Martinez"
LABEL description="NFS SERVER"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd  pam_mount nfs-utils nmap
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
VOLUME /tmp/home
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
