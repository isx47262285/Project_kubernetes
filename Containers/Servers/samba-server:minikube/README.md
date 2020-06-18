# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martínez
### SAMBA

------------------------------------------------------------------------
Servidor samba que contiene como shares los homes de los usuarios, para simplificar el proyecto
hemos incluido los homes de los usuarios en este contenedor.


## SERVIDOR SAMBA

* instalación de los paquetes cifs-utils samba samba-client para desarrollar este servicio.

* Este servidor tiene la función de compartir los share que son los homes de los usuarios vía **cifs**.


### Configuración 

* configuración de los homes (share) en el smb.conf

```
[global]
        workgroup = MYGROUP
        server string = Samba Server Version %v
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        load printers = yes
        cups options = raw
[homes]
        comment = Home Directories
        browseable = no
        writable = yes
;       valid users = %S
;       valid users = MYDOMAIN\%S
```
* instalación básica (install.sh) de los directorios de los homes de los usuarios y añadir a los usuarios unix al servidor samba 

```
mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/pau

chown -R pere.users /tmp/home/pere
chown -R pau.users /tmp/home/pau

echo -e "pere\npere" | smbpasswd -a pere
echo -e "pau\npau" | smbpasswd -a pau
```

* configuracion de los ficheros nsld.conf y nsswitch.conf para tener conectividad  con el servidor ldap y hacer getent passwd para comprobarlo.


* Este servidor esta configurado para funcionar en **detach**.

```
/usr/sbin/smbd && echo "smb Ok" 
/usr/sbin/nmbd && echo "nmb  Ok" 

```


