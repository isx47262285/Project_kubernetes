# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
# Dockerfile HOST NFS
# -------------------------------------
FROM fedora:27
LABEL author="Roberto Altamirano Martinez"
LABEL description="Host NFS"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount nfs-utils iputils pam_krb5 krb5-workstation dhclient iproute nmap bind-utils
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
