# PRÁCTICA NODE

⚠️ IMPORTANTE: https://node.ismaelweb.duckdns.org/

## Índice
- [Creamos un archivo que lo llamaremos server.js](#1-creamos-un-archivo-que-lo-llamaremos-serverjs)
- [Instalacion de node.js](#2-instalacion-de-nodejs)
- [Despliegue](#despliegue)

<hr>

## 1. Creamos un archivo que lo llamaremos server.js 

[server.js](./javascript/server.js)

<hr>

## 2. Instalacion de node.js

Vamos a crear un alias con node para levantarlo de una forma contenedor sin tener que tener instalado node.js en nuestro servidor

```bash
alias node='docker run --rm -it -u $(id -u):$(id -g) -v $(pwd):/app -w /app  node:latest'
```

Levantamos node y creamos el package.json con estos dos comandos

```bash
node npm init

node npm install express
``` 

<hr>

## Despliegue

Para desplegar la aplicacion de node necesitamos crear la imagen y el contenedor 

- [Dockerfile](./docker/Dockerfile)
- [docker-compose.yml](./docker/docker-compose.yml)

Con este comando generamos la imagen
```bash 
docker build -t node .
``` 
Con este comando crearemos el contenedor
```bash
docker composer up -d
```
Probar que funciona entrando por la red

<hr>