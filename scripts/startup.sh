#! /bin/bash

#comprobamos el estado de minikube

minikube status >> /dev/null

if [ $? -gt 0 ]
then
  echo "FATAL: minikube not running"
  echo "HELP: exec: "minikube start [options..]" "
  echo "TRY: minikube start --driver=virtualbox --extra-config=apiserver.service-node-port-range=7-30000"
  exit 1
fi

echo -e "Minikube is running"

echo -e "starting Servers (k8s) \n"


# aplicamos el arranque de nuestros pods 

kubectl create -f ldapserver-app.yaml
echo -e "\n ------------ \n"
sleep 10

kubectl create -f kserver-app.yaml
echo -e "\n ------------ \n"


kubectl create -f samba-app.yaml
echo -e "\n ------------ \n"


kubectl create -f nfs-app.yaml

echo -e "\n ------------ \n"

echo -e " Welcome to \t Gandhi K8S"






