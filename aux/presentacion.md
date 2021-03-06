# Índice

* Introducción
* Puntos a Destacar
* Estructura de Kubernetes
* Estructura del Proyecto
* El Cluster
* Demostración

# Introducción

**¿Qué es Kubernetes?**

Kubernetes fue originalmente un proyecto creado por Google, el cual tiene experiencia de más de 15 años gestionando contenedores. 
Ahora se trata de un proyecto de código abierto, bajo el paraguas de *Cloud Native Computing Foundation (CNCF) y la Fundación Linux*.

**¿Qué significa Kubernetes? ¿Qué significa K8S?**

El nombre Kubernetes proviene del griego y significa timonel o piloto.
Es la raíz de gobernador y de cibernética. 
**K8s** es una abreviación que se obtiene al reemplazar las ocho letras “ubernete” con el número **8**.

# Puntos a destacar
**Ventajas de usar esta tecnología.**

* Orquestación de contenedores en múltiples hosts, ya que no utiliza contenedores como tal, sino que utiliza agrupaciones de contenedores, lo que se conoce como Pod.
* Escalado y auto-escalado: en función del uso de CPU permite el escalado vertical de tus aplicaciones de manera automática o de forma manual.
* Permite optimizar recursos, definiendo dentro de los Pods qué recursos va a necesitar cada contenedor, como puede ser la cuota de disco duro o el límite de memoria RAM que utilice el propio contenedor.
* Autorreparación: en caso de fallo de un contenedor puede reiniciarlo automáticamente. Puede reemplazar o replanificar contenedores cuando un nodo muere.
* Podemos automatizar despliegues, saneamientos de contenedores, subida de versión de aplicaciones y un sinfín de cosas más.

# Puntos a destacar
**¿Donde se puede utilizar Kubernetes?**

Las opciones para utilizar Kubernetes apenas tienen restricción.

* **Bare Metal**: podemos desplegar nuestro cluster directamente sobre máquinas físicas utilizando múltiples sistemas operativos: Fedora, CentOS, Ubuntu, etc.
* **Virtualización On Premise**: si queremos montar nuestro cluster on premise, pero con máquinas virtuales, las posibilidades crecen. Podemos utilizar Vagrant, CloudStack, Vmware, OpenStack, CoreOS, oVirt, Fedora, etc.
* **Soluciones Cloud**: Google Container Engine, Azure, IBM, Kube2Go, Kops (AWS)

# Puntos a destacar

**Evolución de la tecnología informática**

* Conforme al paso del tiempo las nuevas tecnologías han evolucionado y han cambiado el mundo de la informática pasando de:

Servidores físicos --> Servicios Cloud

![](evolution.png)

# Estructura Kubernetes

**Estructura de un Cluster**

![](cluster.png)


# Estructura Kubernetes

**Conceptos de Kubernetes.**

* **Deployment**: Una implementación proporciona actualizaciones declarativas para Pods y ReplicaSets.
* **Service**: Una forma abstracta de exponer una aplicación que se ejecuta en un conjunto de Pods como un servicio de red.
* **Pod**: es la unidad de ejecución básica de una aplicación de Kubernetes, la unidad más pequeña y más simple en el modelo de objetos de Kubernetes que crea o implementa. Un Pod representa procesos que se ejecutan en su racimo.
* **Nodo**: nodo contiene los servicios necesarios para ejecutar Pods, incluye el kubelet, container runtime, kube-proxy.
* **Master**: es el responsable de mantener el estado deseado de tu clúster. Cuando interactúas con Kubernetes, por ejemplo: la línea de comandos kubectl, es la comunicación directa con el master de tu clúster de Kubernetes.



# Esctructura del proyecto

**El proyecto**

Este proyecto necesita varios componentes para su simulación.

* **Minikube**: Cluster de Kubernetes.
* **Hypervisor**: VirtualBox, KVM, Docker, Hyper-V, etc
* **Kubectl**: linea de comandos cliente.
* **imagenes**: Biblioteca DockerHub (por defecto), pero nos sirve cualquier imagen.

# Esctructura del Proyecto.

![](objects.png)


#  Esctructura del Proyecto.

**Esctructura de Gandhi K8S.**

**Servers**

* Servicio LDAP
* Servicio KRB5
* Servicio SAMBA
* Servicio NFS

![](cluster-vacio.png)

# Estructura del Proyecto.

**Estructura del Host**

Utilizaremos dos containers Docker para simular un host que hará la conexión con Gandhi K8S
y validara un usuario de la escuela con sus credenciales.

Tenemos dos versiones de los clientes:

* Container **host-samba**

	Responsable de montar la zona de trabajo (home) vía **cifs**.
	
* Container **host-nfs**

	Responsable de montar la zona de trabajo (home) vía **nfs**.
	

# El cluster

**¿como inicio mi cluster?**

```
minikube start 
```

Nombraremos las dos opciones utilizadas para desarrollar nuestro proyecto:

* `--driver=`

Nos permite especificar el hypervisor con el que vamos arrancar nuestro cluster

* `--extra-config=apiserver.service-node-port-range=7-30000` 

Nos permite abrir un rango de puertos diferente al que usa por defecto minikube.

# El Cluster

**¿ Que puedo hacer en minikube ?**

Ordenes para inspeccionar/interactuar con  nuestro cluster.

```
minikube version
minikube status
minikube ip
minikube ssh
```
---

# El Cluster

Minikube tiene su entorno web para poder inspeccionar la estructura del cluster.

```
minikube dashboard
```

![alt cloud](ui-dashboard.png)

# El Cluster

**¿Que puedo hacer en un cluster de minikube?**

**Crear un Deployment**

```
kubectl create deployment http-prova --image=robert72004/http-prova:minikube
```

**Crear un Service**

```
kubectl expose deployment http-prova --type=NodePort
```
# El Cluster
**¿Que puedo hacer en un cluster de minikube?**

**Escalar un Deployment**

```
kubectl scale deployment http-prova --replicas=2 
```

**Actualizar un Deployment**

```
kubectl set image deployments/http-prova http-prova=robert72004/http-prova:minikubeV2
```

# El Cluster

**monitorizar un deployment, pod o service**

```
kubectl describe deployments.apps http-prova 
kubectl describe pod http-prova
kubectl describe service http-prova
```

**Interactuar con un Pod**

```
kubectl exec -it http-prova /bin/bash
```


# Pasamos a la Demostración

![](saludos.gif)
