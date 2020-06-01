# Version: 0.0.1
# SAMBA-HOMES
# -------------------------------------
FROM fedora:27
LABEL author="Roberto@edt.org Proyecto Kubernetes"
LABEL description="PAM-Samba-homes 2018-2019"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd pam_mount cifs-utils samba samba-client
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
