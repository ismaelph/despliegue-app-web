# PRÁCTICA FLASK

⚠️ IMPORTANTE: https://flask.ismaelweb.duckdns.org/

## Índice
- [Creamos los archivos ](#1-creamos-los-archivos)
- [Levantamos la imagen y el contenedor](#levantamos-la-imagen-y-el-contenedor)

<hr>

## 1. Creamos los archivos 

Primero creamos app y requirements

- [app.py](./archivos/app.py) : va a ser el archivo de la aplicacion creado por python
- [requirements.txt](./archivos/requirements.txt)
- [Dockerfile](./docker/Dockerfile). Imagen que vamos a usar de python
- [docker-compose.yml](./docker/docker-compose.yml): Contenedor de docker

<hr>

## Levantamos la imagen y el contenedor

- Generar la imagen
```bash
docker build .
```

- Generar el compose
```bash
docker compose up -d
```

Ya podriamos ver el proyecto a traves del dns que hallamos metido en el compose 

<hr>