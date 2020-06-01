#! /bin/bash
/opt/docker/install.sh && echo "ok install"
/usr/sbin/httpd  && echo "apache okey "
/usr/sbin/vsftpd
/usr/sbin/xinetd -dontfork && echo "xinetd engegat"


/bin/bash


