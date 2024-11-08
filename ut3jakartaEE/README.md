# PRÁCTICA JAKARTA

⚠️ IMPORTANTE: https://tomcat.ismaelph.duckdns.org/proyect-1.0-SNAPSHOT

## Índice
- [1. Crear una aplicación hecha en JakartaEE](#1-crear-una-aplicación-hecha-en-jakartaee)
- [2. Levantar un servidor Tomcat que despliegue nuestra aplicación](#2-levantar-un-servidor-tomcat-que-despliegue-nuestra-aplicación)
- [3. Desplegar la aplicación](#3-desplegar-la-aplicación)

<hr>

## 1. Crear una aplicación hecha en JakartaEE

1. Instalar Tomcat la versión [windows.zip](https://tomcat.apache.org/download-90.cgi)
2. Abrir el IDE de nuestra preferencia, en mi caso IntelliJ IDEA.
3. Crear un nuevo proyecto y cambiar los siguientes datos:
   - **Generators**: Cambiarlo a Jakarta EE.
   - **Name**: Nombre del proyecto.
   - **Location**: Donde se guardará el proyecto.
   - **Template**: Seleccionar *Web application*.
4. En la siguiente pantalla, seleccionar las dependencias necesarias y asegurarse de tener marcado **Servlet**.
5. Extender todas las carpetas y verificar que están los archivos **index.jsp** (página principal) y **HelloServlet.java** (página secundaria a la que lleva el enlace).
6. Configurar el entorno de ejecución:
   - Abrir el menú de configuraciones (Run > Edit configurations).
   - Añadir una nueva configuración para Tomcat server: Local.
     - Asignar un nombre.
     - En *Before launch*, añadir un Build Artifacts y escoger el **.war**.
     - (Es posible que falle y no aparezca. Asegurarse de permitir los scripts si Microsoft Defender lo solicita).
     - Alternativamente, añadir el artifact en la parte de *Server* en *Deployment*.
   - Una vez configurado, se debería crear una carpeta **target** y al ejecutar se arrancará el proyecto.

<hr>

## 2. Levantar un servidor Tomcat que despliegue nuestra aplicación

1. Configurar un proxy en el servidor.
   - [compose-caddy](./docker/caddy/docker-compose.yml)
   - [compose-tomcat](./docker/tomcat/docker-compose.yml)
2. Crear una carpeta donde se guardará el **.war** del proyecto:
```bash
   -- mkdir aplicaciones
```
3. Crear el contenedor de Tomcat.
4. Levantar los 2 contenedores

<hr>

## 3. Desplegar la aplicación

2. Añadir el proyecto desde el PC local al servidor:
   Ejemplo: -- scp -i ruta/absoluta/ssh/privada ruta/absoluta/proyecto/proyect-1.0-SNAPSHOT.war usuario@ip_privada_o_dns:/ruta
```bash
   -- scp -i C:/Users/usuario1/.ssh/id_ed25519 C:/Users/usuario1/Documents/tomcat/proyect/target/proyect-1.0-SNAPSHOT.war usuario1@usuario1.duckdns.org:/home/usuario1/jakarta/aplicaciones
```

3. En la carpeta **aplicaciones** se debería aver creado un archivo sin la extensión **.war**, que es el proyecto que tu has pasado pero descomprimido.
4. Al acceder a la ruta creada en el Docker Compose seguido de `/proyect-1.0-SNAPSHOT`, deberías poder acceder a la página.
