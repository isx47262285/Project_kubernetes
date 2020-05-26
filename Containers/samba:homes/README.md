# samba:18homes

## roberto@edt asix m06 curs 2018-2019

### descripcion:
> repositorio de un servidor samba que contiene como shares los homes de los usuarios

### configuracion 

* instalacion de los paquetes cifs-utils samba samba-client
* configuracion de los homes (share) en el smb.conf

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
* instalacion basica (install.sh) de los directorios de los homes de los usuarios y añadir a los usuarios unix al servidor samba 

```
mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/pau

chown -R pere.users /tmp/home/pere
chown -R pau.users /tmp/home/pau

echo -e "pere\npere" | smbpasswd -a pere
echo -e "pau\npau" | smbpasswd -a pau
```

* configuracion de los ficheros nsld.conf y nsswitch.conf para tener conectividad  con el servidor ldap y hacer getent passwd para comprovarlo.

#### ejecucion

```
docker run --rm --name samba -h samba --network sambanet -it robert72004/samba:18homes
```



