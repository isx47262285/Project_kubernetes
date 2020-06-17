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


