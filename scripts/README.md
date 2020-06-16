# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
## SCRIPTS

---
Este apartado contiene los ficheros de configuracion de los pods para lanzar los servidores y los servicios.

Cabe destacar que los ficheros .yaml son la manera mas completa de configuracion de los deployments como de los services, sin embargo
existe su version en *command line* pero no la utilizamos porque no se pueden aplicar todas las opciones.


* Configuracion de un **deployment**
El fichero *xxxx-deployment.yaml* contiene configuracion del deployment en el cual especificamos todas las caracteristicas de los pods.

**Lanzamiento completo**
```
kubectl create -f nfs-deployment.yaml
```
**command line**

```
kubectl create deployment nfs-server --image=robert72004/nfs-server:minikube
```

* Ejemplo de **Deployment .yaml**

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-server
  labels:
    app: nfs-server
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nfs-server
  template:
    metadata:
      labels:
        app: nfs-server
    spec:
      containers:
      - name: nfs-server
        image: robert72004/nfs-server:minikubeV2
        imagePullPolicy: Always
        securityContext:
          privileged: true
```


* Configuracion de un **servicio**

El fichero *xxxx-service.yaml* contiene la  configuracion del servicio al cual asociamos un deployment, en este fichero se especifica 
los puertos exportados y el NodePort que es nuestro puerto de conexion.


**Lanzamiento completo**
```
kubectl create -f nfs-service.yaml
```

**command line**

```
kubectl expose deployment nfs-server --type=NodePort --port=111 --target-port=111
```

* Ejemplo de **Service .yaml**

```
apiVersion: v1
kind: Service
metadata:
  name: nfs-server
  labels:
    app: nfs-server
spec:
  type: NodePort
  ports:
  - port: 111
    targetPort: 111
    nodePort: 111
    protocol: TCP
    name: nfs-server
  - port: 2049
    targetPort: 2049
    nodePort: 2049
    protocol: TCP
    name: nfs-server1
  selector:
    app: nfs-server
```
---

* Configuracion del servicio y del deployment en un mismo fichero .yaml


El fichero *xxxx-app.yaml* contiene la  configuracion que conjunta las dos partes importantes de un servidor.

+ Deployment.
+ Service.


**Lanzamiento completo**
```
kubectl create -f nfs-app.yaml
```




