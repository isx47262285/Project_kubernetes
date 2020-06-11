# Introducción

**¿Qué es Kubernetes?**

Kubernetes fue originalmente un proyecto creado por Google, el cual tiene experiencia de más de 15 años gestionando contenedores. 
Ahora se trata de un proyecto de código abierto, bajo el paraguas de *Cloud Native Computing Foundation (CNCF) y la Fundación Linux*.

**¿Qué significa Kubernetes? ¿Qué significa K8S?**

El nombre Kubernetes proviene del griego y significa timonel o piloto.
Es la raíz de gobernador y de cibernética. 
**K8s** es una abreviación que se obtiene al reemplazar las ocho letras “ubernete” con el número **8**.

# Ventajas de usar esta tecnologia.
**Desctacamos**

* Orquestación de contenedores en múltiples hosts, ya que no utiliza contenedores como tal, sino que utiliza agrupaciones de contenedores, lo que se conoce como Pod.
* Facilidad de escalado, tanto a nivel lógico como a nivel físico, es decir, tenemos la posibilidad de añadir nuevos nodos de cómputo a nuestro clúster, aumentando las prestaciones y recursos de hardware disponibles.
* Posibilidad de escalar en número de contenedores que se están ejecutando. Por ejemplo, tenemos un Pod de ejecución de Apache, podemos ampliar el número de ejecuciones por encima, es decir, si tenemos tres y visualizamos que la demanda es creciente, fácilmente podemos escalar a un número mayor para hacer frente a dicha demanda.
* Permite optimizar recursos, definiendo dentro de los Pods qué recursos va a necesitar cada contenedor, como puede ser la cuota de disco duro o el límite de memoria RAM que utilice el propio contenedor.
* Podemos automatizar despliegues, saneamientos de contenedores, subida de versión de aplicaciones y un sinfín de cosas más.

# Evolucion de la tecnologia informatica.

![](evolution.png)
