# adlamin
Manager de infrastructura. Ideal para tener un mecanismo de deploy simple y conciso.

## Requermientos

Docker instalado

## Ambiente recomendado

Un debian con iptables con politicas en DROP.

## Comandos

*create_dmz*: Crea un ambiente que recibe los requests en una interfaz publica.

*create_service*: Crea un servicio.

*deploy*: Deploya un servicio.

## Servicios

Tendremos un directorio, en algun lugar de nuestro VPS que tendra mas subdirectorios. Cada uno contendra un archivo *.service* donde se configurara lo siguiente:

export NETWORK= 
export SUBNET=
export ROUTER_IP=
export PORT=
export PROYECT_NAME=
export GIT_REPO=
export SERVICE_PATH=
