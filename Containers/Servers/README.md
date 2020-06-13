# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
### Containers

* **LDAP**
Imagen de LDAP que contiene la base de datos de los usuarios.

Para este proyecto hemos utilizado nuestro LDAP de la escola del treball con el que hemos trabajado.

* **SAMBA**
Un servidor SAMBA al cual para simplificar complejidad del sistema hemos integrado los homes de los usuarios en la propia imagen.


* **KERBEROS**
La imagen de nuestro servidor KRB5 al cual integramos la conexion con ldap para su validacion de las credenciales.

* **NFS** 
Un servidor NFS al cual para simplificar complejidad del sistema hemos integrado los homes de los usuarios en la propia imagen.

Se configura la exportacion de los homes de los usuarios para su posterior montaje.
