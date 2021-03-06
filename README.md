# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
--------------------------------------------------------------------------------------------------

**¿Qué significa Kubernetes? ¿Qué significa K8S?**

El nombre Kubernetes proviene del griego y significa timonel o piloto.
**K8s** es una abreviación que se obtiene al reemplazar las ocho letras “ubernete” con el número 8.

**¿Qué es Kubernetes?**

Kubernetes fue originalmente un proyecto creado por **Google**, el cual tiene experiencia de más de 15 años gestionando contenedores.
Ahora se trata de un proyecto de código abierto, bajo el paraguas de **Cloud Native Computing Foundation (CNCF) y la Fundación Linux**.

### Objetivo 

Como meta final del proyecto simularemos una estructura de autenticación de usuarios
similar a la que realiza el servidor de **Gandhi** en la Escola del Treball.

Por tanto desarrollaremos el proyecto con varios servidores: **ldap, kerberos, samba y nfs**.

* Podríamos bautizar este proyecto como: **Gandhi (K8S)**.

* Implementaremos los servicios básicos de **atutenticacion** de usuario simulando el login de la escuela, es decir,
que atraves de una cuenta de usuario podemos autenticarnos con las credenciales en  **LDAP** obtener la confirmación
de las credenciales atraves del servidor **KERBEROS**.

* Conseguido este primer paso, el usuario necesitara su zona de trabajo la cual sera importada por otro servicio
externo el cual estará destinado a guardar el **HOME** de los usuarios y el contenido del mismo, es decir, 
aceptadas las credenciales del usuario le montara  una unidad en su directorio de trabajo mediante un servidor
**SAMBA**  o **NFS** según la configuración del cliente.

Para simplificar la estructura del proyecto, hemos incluido los espacios de trabajo dentro de los servidores **SAMBA** y **NFS**.

### ESTRUCTURA 

* El proyecto tendrá dos partes importantes: creación del **CLUSTER** y por otro lado  el desarrollo de los 
**DEPLOYMENTS Y SERVICES** basados en containers de **Docker** que contendrán los servidores: **LDAP, SAMBA, KERBEROS, NFS**.

### Cluster

Para la creación del **cluster** existen dos opciones utilizadas: **kubeadm**  y  **minikube**.
Este proyecto esta basado en **minikube**, por tanto, partimos con unas configuraciones por defecto y centraremos  nuestros esfuerzos en el desarrollo de los
despliegues con sus servicios para simular a **Gandhi**.

Haremos una pequeña mención a *kubeadm*, este método nos obliga a crear toda la configuración del cluster desde cero, lo que implica 
desarrollar una gran parte de configuraciones de redes a nivel interno como DHCP, DNS,etc.

**Representación de la estructura**

![alt cloud](https://github.com/isx47262285/Project_kubernetes/blob/master/aux/objects.png)


* Como hemos podido observar Kubernetes necesita de varios recursos para poderse desarrollar.

- **virtualizador**: kvm, virutalbox, hyperV, Docker,etc.
- **imágenes**: docker, o la URL completa de una imagen almacenada en cualquier cloud.
- **minikube**: el nodo master.
- **kubectl** : sera nuestro comando para administrar nuestro cluster.


### Scripting 

Contaremos con unas plantillas *.yaml* que nos permitirán automatizar los deployments y los servicios.

### Aux

En este apartado encontraremos contenido adicional del proyecto: seguimiento, imágenes, presentación, etc.


### Containers

Kubernetes utiliza **docker hub** como base para alojar las images de los sistemas que desarrolla, pero también
podemos utilizar cualquier cloud que contenga una imagen, solo debemos indicar la url completa.

He colgado las imágenes de los servidores y los clientes en la biblioteca de **Docker hub**.

### MEJORAS

Al utilizar un cluster como minikube hay limitaciones como por ejemplo: no puede generar mas de un NODO o utilizar
opciones como --type:LoadBalancer.

Otras limitaciones tienen que ver con los virtualizadores que se usen, Docker también es aceptado como virtualizador
pero a la hora de realizar pruebas, la aberturas de puertos NodePorts que por defecto son del 30000 al 32627, Docker 
se quejaba porque no podía abrir estos puertos por su política interna, declaraba los puertos como "FILTERED".

Minikube tiene una lista amplia de 'Addons' desactivada y por tanto hay que activar para tener ciertas funcionalidades, por ejemplo,
**metrics** que la hemos activado para tener una vista mas ilustrativa en el dashboard de minikube.

### CONCLUSIÓN.

Utilizar esta tecnología para reconvertir Gandhi al concepto "cloud" es muy interesante y nos permite tener Gandhi disponible en cualquier parte del mundo.

El concepto de un servidor Cloud y la Alta disponibilidad es la tecnología del presente y del futuro.

A nivel personal me ha resultado interesante además de autodidacta.


