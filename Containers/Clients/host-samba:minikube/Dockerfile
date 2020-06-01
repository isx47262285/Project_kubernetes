FROM fedora:27
LABEL author="roberto@edt Proyecto kubernetes"
RUN dnf -y install krb5-workstation passwd cifs-utils authconfig pam_krb5 openssh-clients nss-pam-ldapd procps pam_mount iputils iproute dhclient bind-utils 
RUN mkdir /opt/docker
COPY  * /opt/docker/
WORKDIR /opt/docker
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
CMD ["/opt/docker/startup.sh"]

