# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano

### Objetivo 

Como meta final del proyecto simularemos una estructura de autenticacion de usuarios
similar a la que realiza el servidor de Gandhi en la escola.

Por tanto desarrollaremos el proyecto con varios servicios: ldap, kerberos, samba y nfs.

Podriamos bautizar este proyecto como: Cloud-Gandhi.

* implementaremos los servicios basicos de **atutenticacion** de un usuario de la escuela, es decir,
que atraves de una cuenta de usuario podemos autenticarnos con el servidor **LDAP** y obtener la confirmacion
de las credenciales atraves del servidor **KERBEROS**.

Conseguido este primer paso, el usuario necesitara su zona de trabajo la cual sera importada por otro servicio
externo el cual estara destinado a guardar el **HOME** de los usuarios y el contenido del mismo, es decir, 
aceptadas las credenciales del usuario le montara  una unidad en su directorio de trabajo mediante un servidor
**SAMBA**  o **NFS** segun la configuracion del cliente.

### ESTRUCTURA 

* El proyecto tendra dos partes importantes: creacion del **CLUSTER** y por otro lado  el desarrollo de los 
**KUBELETS** con contendran los servidores o servicios: **LDAP, SAMBA, KERBEROS, NFS**.

En lo que respecta a la base del codigo y el despligue de esto servicios vamos a explicar esta dos fases y los
conceptos basicos de **KUBERNETES**.




