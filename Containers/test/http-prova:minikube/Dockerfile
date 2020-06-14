FROM fedora:27
LABEL author="@robert72004 ASIX M11-SAD"
LABEL description="SSH server"
RUN dnf -y install iproute iputils vim procps nmap uw-imap xinetd passwd httpd net-tools vsftpd 
RUN mkdir /opt/docker
COPY  * /opt/docker/
WORKDIR /opt/docker
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
CMD ["/opt/docker/startup.sh"]

