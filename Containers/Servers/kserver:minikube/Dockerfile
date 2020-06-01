# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
## Servidor Kerberos
# -------------------------------------
FROM fedora:27
LABEL author="Roberto Altamirano Martinez"
LABEL description="Servidor Kerberos"
RUN dnf -y install krb5-server krb5-workstation krb5-libs vim procps
RUN mkdir /opt/docker
COPY  * /opt/docker/
WORKDIR /opt/docker
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
CMD ["/opt/docker/startup.sh"]

