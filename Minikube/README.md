# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
## MINIKUBE
---

## ¿Que es Minikube?

Minikube es una herramienta que administra maquinas virtuales en donde corre un cluster o mejor dicho una instancia de Kubernetes en un solo nodo.
Sin embargo Minikube se apoya de un hypervisor, el cual por default es VirtualBox pero no es la unica opcion, lo cual veremos mas adelante.

Entonces Minikube nos ayuda a correr Kubernetes en un simple nodo en nuestra maquina.

## ¿Que necesito para correr Minikube?

* Hypervisor

Verificar que tu ambiente de desarrollo soporte virtualizacion y un hypervisor instalado.
Minikube suporta varias opciones:

- VirtualBox por default
- HyperKit
- KVM2
- Hyper-V
- Docker



## ¿Como instalo Minikube?

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
```

## ¿como iniciar minikube?

```
minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=7-30000
```

utilizamos estas opciones porque asi nos permite utilizar un rango de puertos utiles para nuestro proyecto.
Con esta configuracion evitamos hacer un nat de puertos porque minikube utiliza un rango por defecto del 30000-32767

## Inspecionar minikube

Podemos realizar una serie de comandos que nos ayudara a verificar las caracteristicas de nuestro nodo, como por ejemplo: estado, version, ip, etc.

A continuacion detallaremos alguna ordenes para inspeccionar nuestro cluster.

```
minikube version
minikube status
minikube ip
```
---

Minikube tiene su entorno web para poder inspecionar la estructura del cluster.

```
minikube dashboard
```

![alt cloud](https://github.com/isx47262285/Project_kubernetes/blob/master/aux/ui-dashboard.png)


## Complementos de minikube

El cluster minikube viene con muchas opciones deshabilitadas, acontinuacion veremos el listado de complementos de minikube y un ejemplo de como 
habilitarlos.

```
minikube addons list
```

|-----------------------------|----------|--------------|
|         ADDON NAME          | PROFILE  |    STATUS    |
|-----------------------------|----------|--------------|
| dashboard                   | minikube | enabled ✅   |
| default-storageclass        | minikube | enabled ✅   |
| efk                         | minikube | disabled     |
| freshpod                    | minikube | disabled     |
| gvisor                      | minikube | disabled     |
| helm-tiller                 | minikube | disabled     |
| ingress                     | minikube | disabled     |
| ingress-dns                 | minikube | disabled     |
| istio                       | minikube | disabled     |
| istio-provisioner           | minikube | disabled     |
| logviewer                   | minikube | disabled     |
| metrics-server              | minikube | enabled ✅   |
| nvidia-driver-installer     | minikube | disabled     |
| nvidia-gpu-device-plugin    | minikube | disabled     |
| registry                    | minikube | disabled     |
| registry-aliases            | minikube | disabled     |
| registry-creds              | minikube | disabled     |
| storage-provisioner         | minikube | enabled ✅   |
| storage-provisioner-gluster | minikube | disabled     |
|-----------------------------|----------|--------------|


* Ejemplo de Activar un addon

```
$ minikube addons enable metrics-server
🌟  The 'metrics-server' addon is enabled

```


* Entrar en minikube

```
minikube ssh
```

---
---

## ¿ Como administro mi cluster minikube?

## Instalar **kubectl** 

Es la herramienta de comunicacion en linea de comandos para desplegar y gestionar aplicaciones en Kubernetes.
Usando kubectl, puedes inspeccionar recursos del clúster; crear, eliminar, y actualizar componentes; explorar tu nuevo clúster; y arrancar aplicaciones de ejemplo.


```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

dnf install -y kubectl
```


Con la herramienta *kubectl* puedes gestionar el cluster, a continuacion explicaremos una serie de comandos ulitizados.

**Crear un Deployment**

```
kubectl create deployment http-prova --image=robert72004/http-prova:minikube
```

**Crear un Service**

```
kubectl expose deployment http-prova --type=NodePort
```

**Escalar un Deployment**

```
kubectl scale deployment http-prova --replicas=2 
```

**Actualizar un Deployment**

```
kubectl set image deployments/http-prova http-prova=robert72004/http-prova:minikubeV2
```

**Subprocesos lanzados deployment, pod o service**

```
kubectl get deployments
kubectl get pods
kubectl get services
```


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




