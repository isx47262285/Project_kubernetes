# Kubernetes
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez
### NFS-SERVER
------------------------------------------------------------------------
Servidor samba que contiene los homes de los usuarios exportados para su montaje, para simplificar el proyecto
hemos incluido los homes de los usuarios en este contenedor.

## SERVIDOR NFS


* **nfs-utils** -> el paquete que contiene todo lo necesario para activar el servicio **NFS** qual contè tot el software necessari per posar-ho tot en funcionament.

* Definimos los recursos a exportar, esta configuracion esta reflejada en: `/etc/exports`

```
/tmp/home 192.168.0.0/16(rw,sync,no_root_squash)
```

* Por lo que respecta al servidor para poder obtener una correcta exportacion de los recursos y funcionalidad de los servicios hay que activar los siguientes servicios,
responsables de las peticiones de los recursos compartidos:


```
/usr/sbin/rpcbind && echo "rpcbind Ok"
/usr/sbin/rpc.statd && echo "rpc.stad Ok"
/usr/sbin/rpc.nfsd && echo "rpc.nfsd Ok"
/usr/sbin/rpc.mountd && echo "rpc.mountd Ok"
```

* **rpcbind** -> 

La utilitat rpcbind és un servidor que converteix els números de programa RPC en adreces universals. Ha d’executar-se a l’amfitrió per poder fer trucades RPC en un servidor d’aquesta màquina.

Quan s'inicia un servei RPC, indica a rpcbind l'adreça a la qual escolta i els números de programa RPC que està preparat per servir. Quan un client desitja fer una trucada RPC a un número de programa donat, primer contacta rpcbind a la màquina del servidor per determinar l'adreça on s'han de enviar les sol·licituds RPC.

La utilitat rpcbind s'hauria d’engegar abans de qualsevol altre servei RPC. Normalment, els servidors RPC estàndard s’inicien mitjançant monitors de port, de manera que rpcbind s’ha d’iniciar abans d’invocar els monitors de port.

Quan rpcbind s'inicia, comprova que certes trucades de traducció de noms a adreces funcionen correctament. Si no, les bases de dades de configuració de la xarxa poden estar corruptes. Atès que els serveis RPC no poden funcionar correctament en aquesta situació, rpcbind informa de la condició i finalitza.

* **rpc.statd** -> 

És un dimoni que escolta les notificacions de reinici d'altres hosts i gestiona la llista d’ordinadors que s’ha de notificar quan es reinicia el sistema local.

rpc.statd registra informació sobre cada interlocutor NFS monitoritzat en un emmagatzematge persistent. Aquesta informació descriu com posar-se en contacte amb un igual remot en cas que es reiniciï el sistema local, com reconèixer el parell supervisat que està informant d'un reinici i com notificar al gestor de bloqueig local quan un interlocutor supervisat indica que s'ha reiniciat.

* **rpc.nfsd** ->

El programa rpc.nfsd implementa la part de nivell d’usuari del NFS  servei. La funcionalitat principal es gestiona mitjançant el mòdul del nucli nfsd.
El programa d’espai d’usuari només especifica quins tipus d’accés s’utilitzen el servei del nucli hauria d’escoltar, quines versions NFS hauria de suportar,i quants fils de nucli hauria d’utilitzar.

* **rpc.mountd** ->

El protocol NFS MOUNT té diversos procediments. Els més importants són **MNT** (muntar una exportació) i **UMNT** (desmuntar una exportació).

Una sol·licitud MNT té dos arguments: un argument explícit que conté el camí del directori arrel de l'exportació que es muntarà i un argument implícit que és l'adreça IP del remitent.

Quan es rep una sol·licitud MNT d'un client NFS, rpc.mountd comprova la ruta i l'adreça IP del remitent contra la seva taula d'exportació. Si l’emissor té permís per accedir a l’exportació sol·licitada, rpc.mountd retorna al client el maneig del fitxer NFS del directori arrel de l’exportació. El client pot utilitzar les sol·licituds de fitxer arrel i NFS LOOKUP per navegar per l’estructura de directoris de l’exportació.

* Una vegada està tot activat exportem els recursos:

```
/usr/sbin/exportfs -av
```

### ALTRES PUNTS

* Aquest servidor està dissenyat per funcionar en mode **detach**:

```
/usr/sbin/rpc.mountd -F
```
