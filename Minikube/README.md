# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
## MINIKUBE


## ¿Que es Minikube?

Minikube es una herramienta que administra maquinas virtuales en donde corre un cluster o mejor dicho una instancia de Kubernetes en un solo nodo.
Sin embargo Minikube se apoya de un hypervisor, el cual por default es VirtualBox pero no es la unica opcion, lo cual veremos mas adelante.

Entonces Minikube nos ayuda a correr Kubernetes en un simple nodo en nuestra maquina.

## ¿Que necesito para correr Minikube?

Instalar kubectl tienes diferentes opciones para instalarlo, mi eleccion es hacerlo con brew.
Verificar que tu ambiente de desarrollo soporte virtualizacion, usa esta liga para verificar esto.
Un hypervisor instalado, Minikube suporta varias opciones:
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


```
minikube version
minikube status 
```

Minikube tiene su entorno web para poder inspecionar la estructura del cluster.

```
minikube dashboard
```

![alt cloud](https://github.com/isx47262285/Project_kubernetes/blob/master/aux/minikube-dashboard.png)

## Complementos de minikube

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

