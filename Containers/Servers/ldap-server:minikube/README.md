# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martínez
### LDAP
------------------------------------------------------------------------

* el servidor **LDAP**, es el encargado de almacenar las cuentas de usuario de la organización.

* Para el desarrollo de esta servidor necesitamos:  **openldap-clients** y **openldap-servers**

* La base de datos esta definida por una **organization** unit.

Hemos añadido grupos que son posixGroup e identifican los miembros por el atributo memberUid.

#### Ejemplo de entradas .ldif

Entitat **grups** per acollir els grups:
```
dn: ou=grups,dc=edt,dc=org
ou: groups
description: Container per a grups
objectclass: organizationalunit
```

Entitat grup 2asix:
```
dn: cn=2asix,ou=grups,dc=edt,dc=org
cn: 2asix
gidNumber: 611
description: Grup de 2asix
memberUid: user06
memberUid: user07
memberUid: user08
memberUid: user09
memberUid: user10
objectclass: posixGroup
```


