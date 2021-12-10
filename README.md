# adlamin
Manager de infrastructura. Ideal para tener un mecanismo de deploy simple y conciso.

## Requermientos

Docker instalado

## Ambiente recomendado

Un debian con iptables con politicas en DROP.

## Comandos

*install*: Inicializa adlamin creando la dmz y la red internal.

*create_service*: Crea un servicio. Recibe nombre, url y dominio.

*deploy*: Deploya un servicio.

## Servicios

Tendremos un directorio, en algun lugar de nuestro VPS que tendra mas subdirectorios. Cada uno contendra un archivo *.service* donde se configurara lo siguiente:

```bash
export NETWORK=#La red
export SUBNET=#La subred donde el servicio va a correr
export ROUTER_IP=#La ip del router del servicio
export PORT=#El puerto que el servicio expone
export PROJECT_NAME=#El nombre del servicio (que tiene que matchear con el nombre del repo)
export GIT_REPO=#Ruta ssh del repo
export IS_PRIVATE=#1 Para registrar el servicio en la red interna
export IS_PUBLIC=#1 Para registrar el servicio en la red publica
export IS_PERSISTENT=#1 Para registrar el servicio con persistencia de datos
export PERSISTENCE_PATH=#Ruta donde se mantendra el estado de ese servicio. Requiere un 1 en IS_PERSISTENT
```
