# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
### Clientes
---


En este apartado encontramos los clientes para nuestra simulacion basada en containers de Docker.

Estos clientes estan configurados de manera que envian sus peticiones a la ip de minikube, 192.168.99.102, que el es host que desplega la estructura de Gandhi K8S.

Por tanto, si se desea reutilizar esta configuracion se debe cambiar la ip contra la que apuntan.

Definimos dos tipos de HOST:

* **host-samba**

Nuestro cliente que utilizara un entorno de trabajo montado en una unidad SAMBA.

Ejecucion:

```
docker run --rm --name host-samba -h host-samba --privileged -it robert72004/host-samba:minikube 
```


* **host-nfs**

Nuestro cliente que utilizara un entorno de trabajo montado en una unidad NFS.

Ejecucion:

```
docker run --rm --name host-nfs -h host-nfs --privileged -it robert72004/host-nfs:minikube

```

