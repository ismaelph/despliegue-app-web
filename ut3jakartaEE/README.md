# PRACTICA JAKARTA

## Índice
1. [Crear una aplicación hecha en JakartaEE](#crear-una-aplicación-hecha-en-jakartaee)
2. [Levantar un servidor Tomcat que despliegue nuestra aplicación](#levantar-un-servidor-tomcat-que-despliegue-nuestra-aplicación)
   - [Cómo crear una máquina virtual con Caddy e instalar Docker](#cómo-crear-una-máquina-virtual-con-caddy-e-instalar-docker)
   - [Guía para levantar un servidor Caddy](#guía-para-levantar-un-servidor-caddy)
3. [Crear una aplicación en Spring utilizando Spring Boot (pendiente final de trimestre)](#crear-una-aplicación-en-spring-utilizando-spring-boot)
4. [Desplegarla](#desplegarla)

---

## 1. Crear una aplicación hecha en JakartaEE

1. 📥 **Instalar la aplicación de Tomcat**  
   - Visita la [página web oficial de Apache Tomcat](https://tomcat.apache.org/download-migration.cgi).
   - Descarga el archivo `windows.zip`.
   - Descomprime el archivo y ya tendrás Tomcat listo.

2. 📝 **Crear el proyecto**  
   - Abre el IDE de tu preferencia. En este ejemplo, usaremos IntelliJ IDEA:
     - Selecciona **New Project**.
     - Completa los datos del nombre del proyecto y su ubicación.
     - En **Template**, selecciona **Web Application**.
     - Cambia **Generator** a **Jakarta EE**.

   - 🔧 **Configuración del servidor Tomcat**:
     - En la parte superior, haz clic en el ícono de las "4 líneas".
     - Selecciona **Run** y luego **Edit Configuration**.
     - Haz clic en el botón `+` y selecciona **Tomcat Server > Local**.
       - En la opción **Deployment**, agrega una nueva configuración:
         - Selecciona **Artifact** y elige tu archivo `proyecto.war`.

3. 🚀 **Ejecutar el proyecto**
   - Haz clic en **Run**. Esto debería iniciar el proyecto y abrirlo en el navegador.










## 2. Levantar un servidor Tomcat que despliegue nuestra aplicación

- 🖥️ **Todo el servidor se está creando en una máquina virtual de Azure.**

- 🌐 **Levantar un servidor de Caddy**.

    - Crea un archivo `docker-compose.yml` dentro de una carpeta llamada `proxy` para configurar el servidor Caddy.
    ```yml
    version: "3.7"
    services:
    caddy:
        container_name: caddy
        image: lucaslorentz/caddy-docker-proxy:ci-alpine
        ports:
        - 80:80
        - 443:443
        environment:
        - CADDY_INGRESS_NETWORKS=caddy
        networks:
        - caddy
        volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        - caddy_data:/data
        restart: unless-stopped

    networks:
    caddy:
        external: true

    volumes:
    caddy_data: {}
    ```

    - Creamos la red

    ```bash
    docker network create caddy
    ```

    - Levantamos el contenedor 
    ```bash
    docker compose up -d
    ```

    



















## 3. Crear una aplicación en Spring utilizando Spring Boot
## 4. Desplegarla
