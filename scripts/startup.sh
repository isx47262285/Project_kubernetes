#! /bin/bash

#comprobamos el estado de minikube

minikube status >> /dev/null

if [ $? -gt 0 ]
then
  echo "FATAL: minikube not running"
  echo "HELP: exec: "minikube start [options..]" "
  exit 1
fi

echo "minikube is running"

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






