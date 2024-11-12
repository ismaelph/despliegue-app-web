# PRACTICA DE Git BARE

⚠️ IMPORTANTE: https://ut4.ismaelweb.duckdns.org/

## INDICE

- [Crear en local un servidor web que sirva un archivo con vuestro nombre.](#1-crear-en-local-un-servidor-web-que-sirva-un-archivo-con-vuestro-nombre)

- [Conectar con un servidor web remoto siguiendo las instrucciones de git Bare + hook](#2-conectar-con-un-servidor-web-remoto-siguiendo-las-instrucciones-de-git-bare--hook)

- [Cambiar el docker de local a remoto](#3-cambiar-el-docker-de-local-a-remoto)

## Descripcion

El ejercicio esta pensado para con un repositorio de git al hacer push poder actualizar el contenedor automaticamente

## 1. Crear en local un servidor web que sirva un archivo con vuestro nombre.

Lo primero que vamos a necesitar es crear un repositorio en github 

Una vez creado vamos a copiar el repositorio y clonarlo donde queramos 

Vamos a añadirle un docker-compose de apache

- [docker composer](./docker/composer-local/docker-compose.yml)

Crear una carpeta html con un index.html dentro

- [html](./html/index.html)

Vamos a levantar el contenedor en local para ver si funciona luego ya lo podemos borrar el contenedor con : 
```bash 
docker compose down
```

## 2. Conectar con un servidor web remoto siguiendo las instrucciones de git Bare + hook

Nos vamos al servidor y tenemos que crear una carpeta

```bash
mkdir hardfloat-blog.git
cd hardfloat-blog.git
```

Luego vamos a usar el siguiente comando que crea un repositorio sin area de trabajo usado para trabajo en remoto en el que no se va a editar en el mismo repositorio directamente

```bash
git init --bare
```

- ❓ Si te da un warning en esta parte por la rama es por que estas usando la rama master que es una rama que ya esta en desuso pero la podemos cambiar por la rama main
```bash
git branch -m master main    
```

Creamos el hook que se va a ejecutar en el servidor después de recibir cada push.

```bash
vim hooks/post-receive
```

Y le pegamos lo siguiente

[post-receive](./hook/post-receive)

damos los permisos de ejecución al script:

```bash	
chmod +x hooks/post-receive
```

Aqui volvemos al repositorio clonado en la maquina local y tendremos que escribir en terminal lo siguiente:

- Agrega un repositorio remoto llamado prod apuntando a la URL SSH especificada, para poder enviar cambios a ese servidor.
```bash
git remote add prod ssh://[username]@host:[port]/home/andres/hardfloat-blog.git
```

#### ⚠️ A partir de ahora todos los commit que hagas seran guardados en el servidor y se borrara el contenedor y se volvera a levantar automaticamente

```bash
git add .

git commit -m "comentario"

git push prod main 
```
- Si todo va bien te deberia pedir la contraseña ssh 
## 3. Cambiar el docker de local a remoto

Tenemos que cambiar el docker-compose que creamos para combrobar que va en local pasarlo a remoto:

[docker-compose](./docker/composer-remoto/docker-compose.yml)

```bash
git add .

git commit -m "comentario"

git push prod main 
```