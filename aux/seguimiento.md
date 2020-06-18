# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martínez
### SEGUIMIENTO DEL PROYECTO.
---

**SEMANA 1**

Durante la primera semana dedicamos tiempo a informarnos de la tecnología kubernetes, utilice el recurso 
de los tutórales guiados proporcionado de la propia pagina de kubernetes para comprender el ecosistema.

Adquirimos conocimientos de nuevos conceptos y comprendimos el concepto cluster.

Comprendemos la linea  de comandos (kubectl) utilizados para la comunicación con nuestro cluster de kuebernetes.

**SEMANA 2**

Fase de descubrimiento, planifique reproducir el tutorial de Kubernetes en mi maquina física.
Para desarrollar esta fase tuve que realizar todas las instalaciones básicas:

+ minikube
+ VM: VirtualBox
+ Kubectl
+ Docker

Tras comprender los diferentes errores encontrados, resolví como solución utilizar VirtualBox como VM dado 
que al probar la opción de Docker y KVM obtuve errores en el arranque de minikube.
Los errores estaban relacionados con la incompatibilidades entre la versión de minikube, Fedora 29 y VM.

Lanzamiento de un primer deployment para comprender los conceptos aprendidos, volvemos a seguir el tutorial de aprendizaje pero esta vez
en nuestra maquina con imágenes de docker de mi repositorio en DockerHub.

Accedimos a la interfaz web del cluster mediante "minikube dashboard", esta interfaz te muestra toda la estructura del cluster
y también de los deployments, pods y servicios operativos.

Una vez comprendidos los conceptos de interacción con Kubectl
lanzamos un deployment "http-prova" (container utilizado como base de pruebas) el cual tiene corriendo diferentes servicios
xinetd y un servidor Apache a los cuales asociamos servicios.
Estos servicios nos mostraron el camino para desarrollar el proyecto, en las dificultades encontradas, vimos que
al exponer los servicios al exterior, minikube utiliza el concepto de NodePort el cual era el punto de acceso a 
nuestro servicio.

Mientras buscábamos una solución a los puertos, nos encontramos que las pruebas de conexión contra el cluster son exitosas.

**SEMANA 3**

A medida que empezamos a entender la comunicación con el cluster, encontramos una dificultad importante, minikube
tiene una configuración por defecto en lo que se refiere a puertos de conexión.
Por defecto se utilizan los puertos del 30000-32767, por tanto al utilizar la liña de comandos nos daba un puerto 
random de este rango, esto obligaba a buscar el puerto concreto para después atacar el servicio apache por ejemplo.

Esta dificultad nos ayudo a inspeccionar los pods, deployments y services. 

'kubectl describe deployment "http-prova"

Una vez descubierto el NodePort para atacar el servicio, todo funcionaba pero esto no es una buena practica, por que 
a nivel de usuario atacamos mediante un cliente  que tiene predefinido un puerto, ejemplo era atacar a nuestro servidor
Apache de pruebas en '192.168.99.100:31254', el servicio respondía la petición pero no es practico ya que lo ideal es trabajar 
en el puerto 80.

Tras varias pruebas encontramos una solución "parche" utilizando 'kubecktl port-foward' que nos permitía una ruta de acceso pero este parche
era un problema porque la variación del NodePort desestimaba este parche.

Finalmente encontramos la solución:

minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=7-30000

Paramos el cluster y lo volvimos arrancar con las opciones mencionadas, lo cual nos permite que utilicemos el rango deseado.
Ahora solo quedaba comprobar que todo funcionaba en los puertos predeterminados en cada servicio y esta prueba resulto con éxito.

**SEMANA 4**

Durante esta semana se plasmo toda la estructura del servidor gandhi en kubernetes.
Creamos los containers con todo lo necesario y también hicimos pruebas de conectividad.

* LDAP
* KSERVER
* SAMBA-SERVER
* NFS-SERVER

En la construcción de los Servidores, el servidor NFS nos planteo un problema con temas de permisos y también con la exportación de los recursos de los homes.
Realizamos diferentes pruebas y se resolvió el problema de permisos aplicando privilegios al despliegue, sin embargo, hay un problema con la exportación de los homes.

Montada toda la estructura, pasamos a construir nuestros clientes para la simulación:

**host-samba**
El host samba tiene configurado una resolución de nombres en su '/etc/hosts' para atacar a la ip de MINIKUBE.
Una hecha toda la configuración pasamos a la prueba final.

La simulación fue exitosa y por tanto comprobamos que el login y el montaje de los homes se han realizado.

**host-nfs**
El host NFS tiene configurado una resolución de nombres en su '/etc/hosts' para atacar a la ip de MINIKUBE.
Hecha toda la configuración pasamos a la prueba del cliente.

En la prueba vemos que la conexión con los servidores existe pero la exportación de los recursos no se produce por tanto no se puede montar el HOME del usuario.


Durante esta semana se hicieron todas las pruebas necesarias para resolver los problemas encontrados y también documentamos el proyecto.





