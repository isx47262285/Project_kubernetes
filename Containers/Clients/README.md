# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
### Clientes
---

En este apartado encontramos los dos clientes para nuestra simulacion:

**host-samba**

Nuestro cliente que utilizara un entorno de trabajo montado en una unidad SAMBA.
Ejecucion:

```
docker run --rm --name host-samba -h host-samba --privileged -it robert72004/host-samba:minikube 
```


**host-nfs**
Nuestro cliente que utilizara un entorno de trabajo montado en una unidad NFS.
Ejecucion:

```
docker run --rm --name host-nfs -h host-nfs --privileged -it robert72004/host-nfs:minikube

```

