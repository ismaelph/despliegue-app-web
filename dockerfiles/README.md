# Dockerfile

## ¿Qué es un Dockerfile?

Un **Dockerfile** es un archivo de texto que contiene una serie de instrucciones que Docker utiliza para construir una imagen. Estas instrucciones definen cómo se debe configurar y construir el entorno del contenedor.

## ¿Cómo se usa un Dockerfile?

Un Dockerfile es la receta para crear una imagen de Docker. Lo usas con el comando `docker build`, que lee el Dockerfile, ejecuta las instrucciones que contiene y genera una imagen basada en el sistema especificado.

## Crear un Dockerfile

** Cuando cargas el dockerfile tiene que ser usado en la misma carpeta si no no funciona **

```bash
cat Dockerfile
FROM debian:latest

COPY archivo.txt /home/pruebas/archivo.txt

ENTRYPOINT echo "Hola alumno"
```

### Editar el Dockerfile

```bash
sudo nano Dockerfile
```

### Construir la imagen

```bash
docker build -t ismaeltest:version001 .
```

### Salida del proceso de construcción

```
[+] Building 0.7s (7/7) FINISHED
 => [internal] load build definition from Dockerfile                             0.0s
 => => transferring dockerfile: 215B                                             0.0s
 => [internal] load metadata for docker.io/library/debian:latest                 0.5s
 => [internal] load .dockerignore                                                0.0s
 => => transferring context: 2B                                                  0.0s
 => [internal] load build context                                                0.0s
 => => transferring context: 30B                                                 0.0s
 => [1/2] FROM docker.io/library/debian:latest                                   0.0s
 => CACHED [2/2] COPY archivo.txt /home/pruebas/archivo.txt                      0.0s
 => exporting to image                                                           0.0s
 => => exporting layers                                                          0.0s
 => => writing image sha256:035fa0d07a0c0e765d665095ad610ecfb5c257d7e360b53c528dfa31c37494d6 0.0s
 => => naming to docker.io/library/ismaeltest:version001                        0.0s
```

### Visualizar las imágenes creadas

```bash
docker images
```

### Ejecución de un contenedor

```bash
docker run --rm ismaeltest:version001
Hola alumno
```

### Etiquetar la imagen como `latest`

etiquetar imagen como `latest` para facilitar su uso:

```bash
docker tag ismaeltest:version001 ismaeltest:latest
```

### Ejecutar contenedor con la etiqueta `latest`

```bash
docker run --rm ismaeltest
Hola alumno
```

### Verificar el contenido del archivo copiado

Para verificar el contenido del archivo `archivo.txt` dentro del contenedor:

```bash
docker run --rm ismaeltest cat /home/pruebas/archivo.txt
Hola alumno
```

### Visualizar las imágenes disponibles

```bash
docker images
REPOSITORY   TAG          IMAGE ID       CREATED         SIZE
ismaeltest   latest       035fa0d07a0c   8 minutes ago   117MB
ismaeltest   version001   ea8e6b9e0199   8 minutes ago   117MB
```
