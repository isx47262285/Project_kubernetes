# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martínez
### NFS-SERVER
------------------------------------------------------------------------
Servidor NFS que contiene los homes de los usuarios exportados para su montaje, para simplificar el proyecto
hemos incluido los homes de los usuarios en este contenedor.

## SERVIDOR NFS


* **nfs-utils** -> el paquete que contiene todo lo necesario para activar el servicio **NFS**.

* Definimos los recursos a exportar, esta configuración esta reflejada en: `/etc/exports`

```
/tmp/home 192.168.0.0/16(rw,sync,no_root_squash)
```

* Por lo que respecta al servidor para poder obtener una correcta exportación de los recursos y funcionalidad de los servicios hay que activar los siguientes servicios,
responsables de las peticiones de los recursos compartidos:


```
/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
/usr/sbin/rpc.mountd && echo "rpc.mountd Ok"
```

* **rpcbind** -> 

es un servicio universal que se encarga de mapear direcciones a números de programa RPC. Este servicio debe correr en un host para que sea capaz de realizar llamadas RPC. 
Cuando un servicio RPC inicia, registra en rpcbind la dirección en la cual está escuchando y los números de programas RPC que está preparado para servir. 
Cuando un programa cliente desea hacer una llamada RPC a un determinado número de programa, primero contacta a rpcbind para determinar la dirección donde los pedidos RPC deben ser enviados.

* **rpc.statd** -> 
Es el daemon que escucha las notificaciones de reinicio de otros clientes y gestiona la lista de ordenadores que se ha de notificar cuando se reinicia el sistema local.

rpc.statd registra la información de cada interlocutor NFS monitorizado en un almacenado persistente, esta información describe como ponerse en contacto con un igual remoto en caso de reinicio del sistema local. 
Como reconocer la maquina supervisada que esta informando de un reinicio y como notificar al gestor de un bloqueo local cuando el interlocutor supervisado indica que se ha reiniciado.


* **rpc.nfsd** ->


El container implementa  rpc.nfsd la parte del nivel de usuario del servicio NFS. Su función principal se gestiona mediante el modulo del núcleo nfsd.

El programa de espacio del usuario solo especifica que tipo de acceso se utilizan en el servicio del núcleo que tiene que escuchar, que versiones de NFS ha de soportar y cuantos hilos de núcleo ha de utilizar.

* **rpc.mountd** ->

El protocolo NFS MOUNT tiene varios procedimientos, pero el mas importante  eso **MNT** (montar una exportación) y **UMNT** (desmontar una exportación).

Una solicitud de MNT tiene dos argumentos: argumento explicito, el camino del directorio raíz de la exportación que se montara y el argumento implícito que es la dirección ip del remitente.

Cuando se recibe la solicitud de MNT de un cliente NFS, rpcmountd comprueba la ruta y la dirección ip del remitente contra la tabla de exportación, si el emisor tiene permisos para acceder a la exportación, rpc.mountd contesta al cliente el manejo del fichero NFS del directorio raíz de la exportación.
El cliente puede utilizar el fichero raíz y NFS LOOKUP para navegar por la estructura de directorios de la exportación.



* Realizada la configuración procedemos a exportar los recursos:

```
/usr/sbin/exportfs -av
```

### Otros Puntos

* Sevidor esta configurado en modo **detach**:

```
/usr/sbin/rpc.mountd -F
```

### Comprobacion del servidor

```
[root@host-nfs docker]# showmount -e 192.168.99.102
Export list for 192.168.99.102:
[root@host-nfs docker]# ^C
```

Desde nuestra maquina local:

```
[roberto@localhost nfs-server:minikube]$ showmount -e 192.168.99.102
Export list for 192.168.99.102:
```

## comprobacion del POD NFS-SERVER

```
[root@nfs-server-56b85444b-vm8r5 docker]# exportfs
/tmp/home     	192.168.0.0/24
/tmp/home     	<world>
```

comprobamos los permisos en el pod

```
[root@nfs-server-56b85444b-vm8r5 docker]# ls /mnt
[root@nfs-server-56b85444b-vm8r5 docker]# ll /tmp/home/  
total 32
drwxr-xr-x 2 admin wheel   4096 Jun 18 07:46 admin
drwxr-xr-x 2 anna  alumnes 4096 Jun 18 07:46 anna
drwxr-xr-x 2 jordi users   4096 Jun 18 07:46 jordi
-rw-r--r-- 1 root  root      71 Jun 18 07:46 local01
-rw-r--r-- 1 root  root      71 Jun 18 07:46 local02
drwxr-xr-x 2 marta alumnes 4096 Jun 18 07:46 marta
drwxr-xr-x 2 pau   users   4096 Jun 18 07:46 pau
drwxr-xr-x 2 pere  users   4096 Jun 18 07:46 pere
```

# Comprobacion interna de minikube
Accedemos a Minikube via ssh y realizamos la prueba de montaje manual para comprobar la exportacion del Deployment.
Averiguamos la ip del docker que esta corriendo dentro de minikube.

```
$ su -
# mount -t nfs 172.17.0.10:/tmp/home /mnt
# ls /mnt
admin  anna  jordi  local01  local02  marta  pau  pere
```

La exportacion se esta realizando correctamente dentro del cluster pero de cara al exterior no esta funcionando.

```
# showmount -e 172.17.0.10
Export list for 172.17.0.10:
/tmp/home (everyone)
```


### Problemas encontrados

Descubrimos que en el desarrollo de este servidor, la exportación a nivel de Container Docker se produce pero cuando este container es la imagen de un subproceso de minikube la exportacion no se realiza al exterior del cluster.

En un primer momento se reportaron errores de permisos pero esto fue solventado aplicando los privilegios al deploymente en minikube.
Cuando esto estaba resuelto durante la comprobación del usuario nos indica que en el montaje del HOME no existe el directorio marcado en la ruta.

Sin embargo, al navegar dentro del pod que genera la exportacion, los puertos TCP 111 y 2049 están habilitados, por otra parte el fichero de exportacion esta enviando la exportacion correcta.
El problema se basa en un corte de la exportacion a nivel del Cluster.

Hemos tratado el tema pero no conseguimos resolverlo.


