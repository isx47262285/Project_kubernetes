# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martínez
### KERBEROS
-----------------------------------------------------------------------------

El servidor **kerberos** validara las contraseñas de los usuarios procedentes del servidor **LDAP** kerberizado.

---

**Autentication Provider AP**

Kerberos proporciona el servicio de proveedor de autenticación, no almacena información de las cuenta de los usuarios tales como: uid, git, shell, etc.
Solo almacena y gestiona los passwords de los usuarios en su base de datos.

* Conocemos los siguientes AP:

	* /etc/passwd que contiene el password (AP) y también la información de la cuenta del usuario (PI).
	* ldap el servicio que contiene los datos de la cuenta del usuario (IP) y también sus passwords (AP).

**Information Provider IP**

Los servicios que almacenan la información de la cuenta del usuario se denomina **information providers**.
Estos servicios proporcionan: el uid, gid, shell, gecos, etc. Los mas habituales son:  /etc/passwd i ldap

Por tanto:

**Kerberos** solo actúa como AP  y no como IP.

### Configuración

* Para este servidor se han instalado los siguientes paquetes: **krb5-server, krb5-workstation, krb5-libs**.

* Este servidor pertenece al realme **EDT.ORG**


cat `krb5.conf`

```
# To opt out of the system crypto-policies configuration of krb5, remove the
# symlink at /etc/krb5.conf.d/crypto-policies which will not be recreated.
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 rdns = false
 default_realm = EDT.ORG
# default_ccache_name = KEYRING:persistent:%{uid}

[realms]
EDT.ORG = {
  kdc = kserver.edt.org
  admin_server = kserver.edt.org
 }

[domain_realm]
.edt.org = EDT.ORG
edt.org = EDT.ORG
```

* En este servidor tenemos definidas las credenciales de los principals, usuarios que pertenecen a Ldap Kerberizado.

```
kadmin.local -q "addprinc -pw pere pere"
kadmin.local -q "addprinc -pw anna anna"
kadmin.local -q "addprinc -pw pau pau"
kadmin.local -q "addprinc -pw marta marta"
kadmin.local -q "addprinc -pw operador operador"
```

* De cara a la administración de los principals, concedemos permisos como administradores y al resto de usuario simplemente de lectura.


```
pere@EDT.ORG *
anna@EDT.ORG *
pau@EDT.ORG *
marta@EDT.ORG *
operador@EDT.ORG *
*@EDT.ORG l
```

* Este Servidor se ejecuta en  **detach**.

```
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork 
```


