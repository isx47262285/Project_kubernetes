# Version: 0.0.1
# ldapserver
# -------------------------------------
FROM fedora:27
LABEL author="Roberto@edt.org Proyecto Kubernetes"
LABEL description="ldapserver"
RUN dnf -y install procps openldap-clients openldap-servers
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
EXPOSE 389
CMD ["/opt/docker/startup.sh"]


