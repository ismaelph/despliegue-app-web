# Práctica 2: Unidad 5 - LDAP

## Índice

1. [Introducción](#0-introducción)
2. [Creación de LDAP](#1-creación-de-ldap)
   - [Preparación del entorno](#preparación-del-entorno)
   - [Configuración de archivos](#configuración-de-archivos)
   - [Levantando los contenedores](#levantando-los-contenedores)
   - [Cargando configuración en LDAP](#cargando-configuración-en-ldap)
   - [Comprobación de IP](#comprobación-de-ip)
3. [Página Web LDAP](#2-página-web-ldap)
   - [Acceso inicial](#acceso-inicial)
   - [Creación de un usuario genérico](#creación-de-un-usuario-genérico)
   - [Verificación en la página web](#verificación-en-la-página-web)

---

## 0. Introducción

Esta práctica tiene como objetivo aprender a configurar y gestionar un servidor LDAP, integrándolo con un contenedor Docker y una interfaz web.

---

## 1. Creación de LDAP

### Preparación del entorno

Primero creamos la máquina virtual y accedemos a ella:

```bash
vagrant up
vagrant ssh
```

Dentro de la máquina virtual, creamos la carpeta `www` y nos ubicamos en ella:

```bash
mkdir www
cd www
```

### Configuración de archivos

Creamos el archivo `index.html`:

```bash
nano index.html
```

Creamos el archivo `docker-compose.yml`:

```bash
nano docker-compose.yml
```

- [docker-compose.yml](/archivos/docker-compose.yml)

Además, configuramos los siguientes archivos necesarios para el LDAP:

```bash
nano add-group.ldif 
nano add-ou-groups.ldif 
nano add-ou-users.ldif
nano apache-security.conf
```

- [add-group.ldif](/archivos/add-group.ldif)
- [add-ou-groups.ldif](/archivos/add-ou-groups.ldif)
- [add-ou-users.ldif](/archivos/add-ou-users.ldif)
- [apache-security.conf](/archivos/apache-security.conf)

### Levantando los contenedores

Iniciamos los contenedores definidos en el archivo `docker-compose.yml`:

```bash
docker compose up -d
```

### Cargando configuración en LDAP

Copiamos los archivos de configuración al contenedor LDAP:

```bash
docker cp add-ou-users.ldif ldap:/add-ou-users.ldif
docker cp add-ou-groups.ldif ldap:/add-ou-groups.ldif
docker cp add-group.ldif ldap:/add-group.ldif
```

Accedemos a la consola del contenedor LDAP:

```bash
docker exec -it ldap bash
```

Agregamos la información del usuario administrador con la contraseña correspondiente:

```bash
ldapadd -x -D "cn=admin,dc=ejemplo,dc=com" -w "admin1234" -f /add-ou-users.ldif
ldapadd -x -D "cn=admin,dc=ejemplo,dc=com" -w "admin1234" -f /add-ou-groups.ldif
ldapadd -x -D "cn=admin,dc=ejemplo,dc=com" -w "admin1234" -f /add-group.ldif
```

Salimos de la consola del contenedor:

```bash
exit
```

### Comprobación de IP

Verificamos la IP asignada:

```bash
ip a | grep eth1
```

---

## 2. Página Web LDAP

### Acceso inicial

Ingresamos en el navegador la IP que nos proporcionó la máquina virtual.

Nos autenticamos como administrador con las siguientes credenciales:

- **Usuario:** `cn=admin,dc=ejemplo,dc=com`
- **Contraseña:** `admin1234`

### Creación de un usuario genérico

Una vez dentro, seleccionamos la carpeta que corresponde al usuario. Hacemos clic en el botón con forma de estrellita que indica *"Create new entry here"*.

Seleccionamos la opción *Generic: User Account* y completamos el formulario con los datos necesarios, incluyendo la contraseña. Asignamos el **GID Number** como `usuarios`. Guardamos los cambios y hacemos *commit*.

### Verificación en la página web

Accedemos a la IP asignada en el puerto `8080`. Debería mostrarse un login, donde ingresamos con el usuario y contraseña creados.

Una vez autenticados, se mostrará la página HTML que configuramos al inicio.


