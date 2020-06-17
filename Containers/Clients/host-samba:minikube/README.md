# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
### Host-samba.
-----------------------------------------------------------------------

Este container simula un cliente que montara el home del usuario via cifs o samba.


### Configuracion

El cliente necesita una serie de paquetes importantes para la simulacion:

**cifs-utils** -> Paquete importante para hacer el montaje de los  homes via **cifs**.

**nss-pam-ldapd** -> paquete responsalbe de la **conexion** amb LDAP.

**pam_mount** -> Paquete que permite la configuracion del  **mount** dels homes.

**krb5-workstation** -> paquete que interactua con **kerberos** para validar las credenciales de los usuarios.

---

Instalados los paquetes necesarios es importante saber las configuraciones necesarias responsables de la validacion de las credenciales y el montaje de los homes.

`krb5.conf` -> Fichero que contiene la configuracion de kerberos, incluido las ubicaciones KDCs y servidores de administracion para los dominios de interes de kerberos. 

`ldap.conf` -> Configuracion del entorno Ldap.

`nslcd.conf` -> Configuracion del daemon del servidor de nombres Ldap.

`nsswitch.conf``-> Se utiliza para la biblioteca C de GNU y otras aplicaciones a determinar las fuentes de la informacion sobre el nombre del servicio en abanico de categorias y el orden correcto.
Cada categoria de la informacion se identifica mediante un nombre de base de datos.


`pam_mount.conf.xml` ->  Es el fichero encargado de montar los recursos en el momento de iniciar sesion, en este caso buscara el recurso y montara el home via **cifs**

```
<volume user="*" fstype="cifs" server="samba-server" path="%(USER)"  mountpoint="~/%(USER)" />
```

`system-auth` -> Es el fichero que gestiona el inicio de sesion y que puntos tiene que examinar: **validadcion ldap, auth kerberos y montaje del home**.

```
#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.
auth        required      pam_env.so
auth        sufficient    pam_unix.so nullok
auth        optional      pam_mount.so
auth        sufficient    pam_krb5.so use_first_pass
auth        required      pam_deny.so

account     sufficient    pam_unix.so broken_shadow
account     sufficient    pam_localuser.so
account     sufficient    pam_succeed_if.so uid < 1000 quiet
account     [default=bad success=ok user_unknown=ignore] pam_krb5.so
account     required      pam_permit.so

password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=
password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok
password    sufficient    pam_krb5.so use_authtok
password    required      pam_deny.so

session     optional      pam_keyinit.so revoke
session     required      pam_limits.so
-session     optional      pam_systemd.so
session     optional      pam_mkhomedir.so
session     [success=2  default=ignore] pam_succeed_if.so uid > 5000
session     optional      pam_mount.so
session sufficient 	pam_krb5.so
session sufficient 	pam_unix.so
```

## Comprobacion

```
roberto@localhost Project_kubernetes]$ docker run --rm --name host-samba -h host-samba --privileged -it robert72004/host-samba:minikube 
Changing password for user local01.
passwd: all authentication tokens updated successfully.
Changing password for user local02.
passwd: all authentication tokens updated successfully.
Changing password for user local03.
passwd: all authentication tokens updated successfully.
ok install
nslcd Ok
nscd: 73 monitoring file `/etc/passwd` (1)
nscd: 73 monitoring directory `/etc` (2)
nscd: 73 monitoring file `/etc/group` (3)
nscd: 73 monitoring directory `/etc` (2)
nscd: 73 monitoring file `/etc/hosts` (4)
nscd: 73 monitoring directory `/etc` (2)
nscd: 73 monitoring file `/etc/resolv.conf` (5)
nscd: 73 monitoring directory `/etc` (2)
nscd: 73 monitoring file `/etc/services` (6)
nscd: 73 monitoring directory `/etc` (2)
nscd: 73 disabled inotify-based monitoring for file `/etc/netgroup': No such file or directory
nscd: 73 stat failed for file `/etc/netgroup'; will try again later: No such file or directory
nscd Ok
```

**login por parte del usuario**

```
[user01@host-samba ~]$ su - pere
Password: 
Creating directory '/tmp/home/pere'.

[pere@host-samba ~]$ mount -t cifs 
//samba-server/pere on /tmp/home/pere/pere type cifs (rw,relatime,vers=3.1.1,cache=strict,username=pere,uid=5001,forceuid,gid=100,forcegid,addr=192.168.99.102,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,rsize=4194304,wsize=4194304,bsize=1048576,echo_interval=60,actimeo=1)

pere@host-samba ~]$ df -h
Filesystem           Size  Used Avail Use% Mounted on
overlay              118G   35G   78G  31% /
tmpfs                7.8G     0  7.8G   0% /dev
tmpfs                7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5            118G   35G   78G  31% /etc/hosts
shm                   64M     0   64M   0% /dev/shm
//samba-server/pere   17G  6.9G   11G  41% /tmp/home/pere/pere
```


### PUNTS A DESTACAR

* Este cliente esta configurado para que ataque a la ip  **192.168.99.102** de minikube, lugar donde se encuentra nuestro cluster con los servidores activos. 

* En la instalacion hemos añadido una linia importante para la resolucion de nombres correcta.

```
echo "192.168.99.102 ldap kserver.edt.org samba-server nfs-server" >> /etc/hosts
```





