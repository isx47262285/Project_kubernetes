#! /bin/bash

#comprobamos el estado de minikube

minikube status >> /dev/null

if [ $? -gt 0 ]
then
  echo "minikube not running"
  echo "please start minikube"
  exit 1
fi

echo "minikube is running"

# aplicamos el arranque de nuestros pods 

kubectl create -f ldapserver-app.yaml

sleep 5

kubectl create -f kserver-app.yaml

sleep 10

kubectl create -f samba-server.yaml


