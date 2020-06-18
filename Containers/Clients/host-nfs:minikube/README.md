# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
### Host-nfs.
-----------------------------------------------------------------------

Este container simulara un cliente que monta su home via NFS, al realizar la conexion y el login con credenciales de usuario, simularemos el login de un alumno.


### Configuracion

* host-nfs requiere un software determinado para funcionar correctamente, enumeramos los paquetes utilizados:

**nfs-utils** -> responsable del montaje de los homes **nfs**.

**nss-pam-ldapd** -> conectividad con ldapserver.

**pam_mount** -> responsable del **mount** de los homes.

**krb5-workstation** -> paquete que interactua con **kerberos** para validar las credenciales de los usuarios.

---

Instalados los paquetes necesarios es importante saber las configuraciones necesarias responsables de la validacion de las credenciales y el montaje de los homes.


`krb5.conf` -> Fichero que contiene la configuracion de kerberos, incluido las ubicaciones KDCs y servidores de administracion para los dominios de interes de kerberos. 

`ldap.conf` -> Configuracion del entorno Ldap.

`nslcd.conf` -> Configuracion del daemon del servidor de nombres Ldap.

`nsswitch.conf``-> Se utiliza para la biblioteca C de GNU y otras aplicaciones a determinar las fuentes de la informacion sobre el nombre del servicio en abanico de categorias y el orden correcto.
Cada categoria de la informacion se identifica mediante un nombre de base de datos.

`pam_mount.conf.xml` ->  Es el fichero encargado de montar los recursos en el momento de iniciar sesion, en este caso buscara el recurso y montara el home via **nfs**.

```
<volume user="*" fstype="nfs" server="nfs-server" path="/tmp/home/%(USER)" mountpoint="~/%(USER)" uid="%(USER)" gid="%(GROUP)"/>
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
session sufficient pam_krb5.so
session sufficient pam_unix.so
```

* Cabe destacar que primero debemos arrancar los siguientes servicios para que tengamos los datos del usuario en LDAP y nos valide KERBEROS.

```
/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"
```

* Aparte debemos tener encuenta arrancar los siguientes servicios para establecer las conexion nfs y responder a las peticiones:

```
/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
```


### PUNTS A DESTACAR

* Este cliente esta configurado para que ataque a la ip  **192.168.99.102** de minikube, lugar donde se encuentra nuestro cluster con los servidores activos. 

* En la instalacion hemos añadido una linia importante para la resolucion de nombres correcta.

```
echo "192.168.99.102 ldap kserver.edt.org samba-server nfs-server" >> /etc/hosts
```


### Comprobacion

```
hanging password for user local01.
passwd: all authentication tokens updated successfully.
Changing password for user local02.
passwd: all authentication tokens updated successfully.
Changing password for user local03.
passwd: all authentication tokens updated successfully.
Install Ok
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
rpcbind Ok
rpc.stad Ok
rpc.nfsd Ok
[root@host-nfs docker]# 
```

**login del usuario**

```
ser01@host-nfs ~]$ su - pere
Password: 
(pam_mount.c:365): pam_mount 2.15: entering auth stage
Creating directory '/tmp/home/pere'.
(pam_mount.c:568): pam_mount 2.15: entering session stage
(mount.c:782): Could not get realpath of /tmp/home/pere/pere: No such file or directory
(mount.c:263): Mount info: globalconf, user=pere <volume fstype="nfs" server="nfs-server" path="/tmp/home/pere" mountpoint="/tmp/home/pere/pere" cipher="(null)" fskeypath="(null)" fskeycipher="(null)" fskeyhash="(null)" options="" /> fstab=0 ssh=0
(mount.c:305): mkmountpoint: checking /tmp
(mount.c:305): mkmountpoint: checking /tmp/home
(mount.c:305): mkmountpoint: checking /tmp/home/pere
(mount.c:305): mkmountpoint: checking /tmp/home/pere/pere
(mount.c:330): mkdir[5001] /tmp/home/pere/pere
(mount.c:660): Password will be sent to helper as-is.
command: 'mount' '-tnfs' 'nfs-server:/tmp/home/pere' '/tmp/home/pere/pere' 
...

(mount.c:554): 717 762 0:70 / /proc/fs/nfsd rw,relatime - nfsd nfsd rw
(pam_mount.c:522): mount of /tmp/home/pere failed
command: 'pmvarrun' '-u' 'pere' '-o' '1' 
(pmvarrun.c:303): creating /run/pam_mount(pmvarrun.c:254): parsed count value 0
(pam_mount.c:441): pmvarrun says login count is 1
(pam_mount.c:660): done opening session (ret=0)

[pere@host-nfs ~]$ df -h
Filesystem      Size  Used Avail Use% Mounted on
overlay         118G   36G   77G  32% /
tmpfs           7.8G     0  7.8G   0% /dev
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/sda5       118G   36G   77G  32% /etc/hosts
shm              64M     0   64M   0% /dev/shm

```

El mount de su home no se produce, comprobamos si esta exportando el recurso:

```
[root@host-nfs docker]# showmount -e 192.168.99.102
Export list for 192.168.99.102:
[root@host-nfs docker]# ^C
```

Desde nuestra maquina local:

```
[roberto@localhost nfs-server:minikube]$ showmount -e 192.168.99.102
Export list for 192.168.99.102:
```

## comprobacion del POD NFS-SERVER
```
[root@nfs-server-56b85444b-vm8r5 docker]# exportfs
/tmp/home     	192.168.0.0/24
/tmp/home     	<world>
```

comprobamos los permisos en el pod

```
[root@nfs-server-56b85444b-vm8r5 docker]# ls /mnt
[root@nfs-server-56b85444b-vm8r5 docker]# ll /tmp/home/  
total 32
drwxr-xr-x 2 admin wheel   4096 Jun 18 07:46 admin
drwxr-xr-x 2 anna  alumnes 4096 Jun 18 07:46 anna
drwxr-xr-x 2 jordi users   4096 Jun 18 07:46 jordi
-rw-r--r-- 1 root  root      71 Jun 18 07:46 local01
-rw-r--r-- 1 root  root      71 Jun 18 07:46 local02
drwxr-xr-x 2 marta alumnes 4096 Jun 18 07:46 marta
drwxr-xr-x 2 pau   users   4096 Jun 18 07:46 pau
drwxr-xr-x 2 pere  users   4096 Jun 18 07:46 pere
```

# Comprobacion interna de minikube
Accedemos a Minikube via ssh y realizamos la prueba de montaje manual para comprobar la exportacion del Deployment.
Averiguamos la ip del docker que esta corriendo dentro de minikube.

```
$ su -
# mount -t nfs 172.17.0.10:/tmp/home /mnt
# ls /mnt
admin  anna  jordi  local01  local02  marta  pau  pere
```

# Conclusion.

Se realizo la prueba como un Container de Docer en nuestra maquina y la exportacion se produce sin problemas.
por tanto es una limitacion de minikube que nos corta la comunicacion en lo que a exportacion de recursos se refiere.



