# KUBERNETES
## @edt ASIX M14-PROJECTE Curs 2019-2020
## Roberto Altamirano Martinez


### SEGUIMIENTO DEL PROYECTO.


**SEMANA 1**

Durante la primera semana dedicamos tiempo a informarnos de la tecnologia kubernetes, utilice el recurso 
de los tutoriales guiados proporcionado de la propia pagina de kubernetes para comprender el ecosistema.

Aquirimos conocimientos de nuevos conceptos y comprendimos el concepto cluster.

**SEMANA 2**

Fase de descubrimiento, planifique reproducir el tutorial de Kubernetes en mi maquina fisica.
Para desarrollar esta fase tuve que realizar todas las instalaciones basicas:
+ minikube
+ VM: VirtualBox
+ Kubectl
+ Docker

Tras comprender los diferentes errores encontrados, resolvi como solucion utilizar VirtualBox como VM dado 
que al probar la opcion de Docker y KVM obtuve errores en el arranque de minikube.
Los errores estaban relacionados con la incompatibilidades entre la version de minikube, Fedora 29 y VM.

Lanzamiento de un primer deployment para comprender los conceptos aprendidos.


Accedimos a la interfaz web del cluster mediante "minikube dashboard", esta interfaz te muestra toda la estructura del cluster
y tambien de los deployments, pods y servicios operativos.

**SEMANA 3**

Esta semana fue un punto de inflexion importante, una vez comprendidos los conceptos de interaccion con Kubectl
lanzamos un deployment "http-prova" (container utilizado como base de pruebas) el cual tiene corriendo diferentes servicios
xinetd y un servidor Apache a los cuales asociamos servicios.
Estos servicios nos mostraron el camino para desarrollar el proyecto, en las dificultades encontradas, vimos que
al exponer los servicios al exterior, minikube utiliza el concepto de NodePort el cual era el punto de acceso a 
nuestro servicio.

A medida que empezamos a entender la comunicacion con el cluster, encontramos una dificultad importante, minikube
tiene una configuracion por defecto en lo que se refiere a puertos de conexion.
Por defecto se utilizan los puertos del 30000-32767, por tanto al utilizar la linia de comandos nos daba un puerto 
random de este rango, esto obligaba a buscar el puerto concreto para despues atacar el servicio apache por ejemplo.

Esta dificultad nos ayudo a inspecionar los pods, deployments y services. 

'kubectl describe deployment "http-prova"

Una vez descubierto el NodePort para atacar el servicio, todo funcionaba pero esto no es una buena practica, por que 
a nivel de usuario atacamos mediante un cliente  que tiene predefinido un puerto, ejemplo era atacar a nuestro servidor
Apache de pruebas en '192.168.99.100:31254', el servicio respondia la peticion pero no es practico ya que lo ideal es trabajar 
en el puerto 80.

Tras varias pruebas encontramos una solucion "parche" utilizando 'kubecktl port-foward' que nos permitia una ruta de acceso pero este parche
era un problema porque la variacion del NodePort desestimaba este parche.

Finalmente encontramos la solucion:

minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=7-30000

Paramos el cluster y lo volvimos arrancar con las opciones mencionadas, lo cual nos permite que utilicemos el rango deseado.
Ahora solo quedaba comprobar que todo funcionaba en los puertos predeterminados en cada servicio y esta prueba resulto con exito.

**SEMANA 4**

Durante esta semana se plasmo toda la estructura del servidor gandhi en kubernetes.
Creamos los containers con todo lo necesario y tambien hicimos pruebas de conectividad.







