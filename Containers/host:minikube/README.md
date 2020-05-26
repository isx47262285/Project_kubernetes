### k18:khostpamldap

## un servidor cliente que comunica amb kerberos 
> objectiu  conectar amb ldap els usuaris kerberos autentica y el pam monta 

 docker run --rm --name khostpl -h khostpl --network mynet -it robert72004/k18:khostpl

tendremos:
* pam 
* ldap 
* kerberos

execucio:

docker run --rm  --name ldap.edt.org -h ldap.edt.org --network mynet -d robert72004/ldapserver_18roberto

añadirmos los ficheros de nslcd y nsswitch  y modificamos la parte del ldap que sea ldap.edt.org 

tambien vamos a modificar la authenticacio del servidor 
usuaris en ldap 
passwd en kerberos
homes >> no los monta, feina a fer!!

exemple del auth.sh:

#! /bin/bash
# @edt ASIX-M06
# -----------------
#authconfig  --enableshadow --enablelocauthorize --enableldap  --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' --enableldapauth  --updateall


authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.edt.org' \
            --krb5adminserver='kserver.edt.org' --krb5realm='EDT.ORG' \
            --updateall


 
