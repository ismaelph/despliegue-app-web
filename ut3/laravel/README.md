# PRÁCTICA LARAVEL

⚠️ IMPORTANTE: https://laravel.ismaelph.duckdns.org/

## Índice
- [1. Crear alias](#1-Crear-alias-de-php-y-composer)
- [2. Crear proyecto](#2-Crear-proyecto)

<hr>

## 1. Crear alias de php y composer

Vamos a crear un alias en el que se guarde un docker run de php y composer para tener el php y composer sin tener la necesidad de tenerlos instalados en el sistema

- alias de php
```bash
alias php='docker run -u $(id -u):$(id -g) --rm -it -v $(pwd):/usr/src/myapp -w /usr/src/myapp php:8.2-cli php'
```

- alias de composer 
```bash
alias composer='docker run -u $(id -u):$(id -g) --rm -it -v $(pwd):/app composer composer'
```

- levantar los alias
```bash
php -v

composer -v
```
<hr>

## 2. Crear proyecto

Ahora tenemos que crear la carpeta del proyecto yo la voy a guardar dentro de una carpeta laravel por tenerlo mas ordenado

```bash
mkdir laravel
cd laravel
```

Dentro de la carpeta laravel crearemos el proyecto
```bash
composer create-project laravel/laravel holamundo
```

ahora entramos en la carpeta de holamundo y vamos a crear una imagen Dockerfile y un docker-compose 

- [Dockerfile](./docker/Dockerfile)
- [docker-compose.yml](./docker/docker-compose.yml)

- Vamos a levantar primero la imagen de laravel por que el compose necesita de esa imagen
```bash
docker build -t laravel .
```
- Ahora una vez acabe de generar la imagen crearemos ya el contenedor 
```bash
docker compose up -d
```

- Ya podriamos entrar a laravel a traves del dns que pusimos en el docker-compose 