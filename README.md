# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano

¿Qué significa Kubernetes? ¿Qué significa K8S?
El nombre Kubernetes proviene del griego y significa timonel o piloto.
**K8s** es una abrevación que se obtiene al reemplazar las ocho letras “ubernete” con el número 8.

¿Qué es Kubernetes?
Kubernetes fue originalmente un proyecto creado por **Google**, el cual tiene experiencia de más de 15 años gestionando contenedores.
Ahora se trata de un proyecto de código abierto, bajo el paraguas de **Cloud Native Computing Foundation (CNCF) y la Fundación Linux**.

### Objetivo 

Como meta final del proyecto simularemos una estructura de autenticacion de usuarios
similar a la que realiza el servidor de **Gandhi** en la escola.

Por tanto desarrollaremos el proyecto con varios servicios: ldap, kerberos, samba y nfs.

* Podriamos bautizar este proyecto como: **Cloud-Gandhi**.

* Implementaremos los servicios basicos de **atutenticacion** de un usuario de la escuela, es decir,
que atraves de una cuenta de usuario podemos autenticarnos con el servidor **LDAP** y obtener la confirmacion
de las credenciales atraves del servidor **KERBEROS**.

* Conseguido este primer paso, el usuario necesitara su zona de trabajo la cual sera importada por otro servicio
externo el cual estara destinado a guardar el **HOME** de los usuarios y el contenido del mismo, es decir, 
aceptadas las credenciales del usuario le montara  una unidad en su directorio de trabajo mediante un servidor
**SAMBA**  o **NFS** segun la configuracion del cliente.

### ESTRUCTURA 

* El proyecto tendra dos partes importantes: creacion del **CLUSTER** y por otro lado  el desarrollo de los 
**KUBELETS** basados en containers de **Docker** que contendran los servidores o servicios: **LDAP, SAMBA, KERBEROS, NFS**.

#### Cluster
Para la creacion del **cluster** existen dos opciones utilizadas: **kubeadm**  y  **minikube**.
Este proyecto esta basado en **minikube**, se ha optado por esta via dado que centraremos nuestros esfuerzos en el desarrollo de los
servicios necesarios para simular a **Gandhi**.

Haremos una pequeña mencion a *kubeadm*, este metodo nos obliga a crear toda la configuracion del cluster desde cero, lo que implica 
desarrollar una gran parte de configuraciones de redes a nivel interno como DHCP, DNS,etc.

* colocaremos una imagen representativa de la  estructura.

![alt cloud](https://github.com/isx47262285/Project_kubernetes/blob/master/aux/container_evolution.png)


* Como hemos podido observar Kubernetes necesita de varios recursos para poderse desarrollar.
- **virtualizador**: kvm, virutalbox, hyperV, Docker,etc.
- **imagenes**: docker, o la URL completa de una imagen almacenada en cualquier cloud.
- **minikube**: el nodo master.
- **kubectl** : sera nuestro comando para administrar nuestro cluster.

### Scripting 

Contaremos con unas plantillas *.yaml* que nos permetiran automatizar los deployments y los servicios.



### Containers

Kubernetes utiliza **docker hub** como base para alojar las images de los sistemas que desarrolla, pero tambien
podemos utilizar cualquier cloud que contenga una imagen, solo debemos indicar la url completa.

### MEJORAS

Al utilizar un cluster como minikube hay limitaciones como por ejemplo:  administrar mas de un NODO o utilizar
opciones como --type:LoadBalancer no soportadas en cluster alojados en maquinas de manera virtual.

Otras limitaciones tienen que ver con los virtualizadores que se usen, Docker tambien es aceptado como virtualizador
pero a la hora de realizar pruebas, la aberturas de puertos NodePorts que por defecto son del 30000 al 32627, Docker 
se quejaba porque no podia abrir estoy puertos por su politica interna.





