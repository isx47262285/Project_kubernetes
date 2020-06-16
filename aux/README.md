# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
## SCRIPTS

---
Este apartado contiene los ficheros de configuracion de los pods para lanzar los servidores y los servicios.

* Configuracion de un deployment
```
kubectl create -f nfs-deployment.yaml
```

* Configuracion de un servicio

```
kubectl create -f nfs-service.yaml
```
* Configuracion del servicio y del deployment en un mismo fichero .yaml

```
kubectl create -f nfs-app.yaml
```
---

* Ejemplo de **Service**

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

* Ejemplo de **Deployment**

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

