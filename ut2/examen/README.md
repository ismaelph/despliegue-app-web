# EXAMEN

## INSTALAR DOCKER 

```bash
curl -fsSl https://get.docker.com -o get-docker.sh
```

```bash
sudo sh get-docker.sh 
```

## CREAR UN USUARIO CON PERMISOS PARA EVITAR USAR SUDO

```bash
sudo groupadd docker
```
```bash
sudo usermod -aG docker $USER 
```
```bash
newgrp docker
```

## VAMOS A CREAR LAS REDES QUE USAREMOS EN LA TAREA

- Vemos las redes que hay

```bash
docker network ls
```

- Nos da todas estas redes
```bash
NETWORK ID     NAME      DRIVER    SCOPE
dc2680c7488e   bridge    bridge    local
40af50e251cd   host      host      local
e34e783ef335   none      null      local
```

- Vamos a crear un par mas
```bash
docker network create red_proxy
```
```bash
docker network create red_monitor
```

## CREAR UNA CARPETA CON LA PAGINA QUE VAMOS A VER

```bash
mkdir public
```
```bash 
nano public/index.html
```
```bash
cat public/index.html 
buenas tardes 
```

## CREAR UN CADDYFILE PARA EL USO DEL PROXY

```bash
nano Caddyfile 
```
- contenido
- Esto lo que va a hacer es redirigirnos con esta url al contenedor apache por el puerto 80
```bash
apache.redespavon.duckdns.org {
        reverse_proxy apache:80
}
monitor.redespavon.duckdns.org {
        reverse_proxy kuma:3001
}
```
## CREAMOS EL DOCKER COMPOSE CON TODOS LOS SERVICIOS

```bash
nano docker-compose.yml
```
```bash
version: "3"
services: 
    caddy:
        image: caddy:latest 
        container_name: caddy
        volumes:
            - ./Caddyfile:/etc/caddy/Caddyfile
        networks:
            - red_proxy
            - red_monitor
        ports:
            - "80:80"
            - "443:443"
    php-apache:
        image: php:apache
        container_name: apache
        volumes:
            - /home/pavon/public:/var/www/html
        networks:
            - red_proxy
            - red_monitor
    uptime-kuma:
        image: louislam/uptime-kuma:1
        container_name: kuma
        ports:- "3001:3001"
        networks:
            - red_monitor
networks:
    red_proxy:
        external: true
    red_monitor:
        external: true
volumes:
    caddy_data:
    caddy_config:     
``` 

- con el siguiente comando levantamos el compose osea los 3 contenedores
```bash
docker compose up -d 
```
- Hacemos el siguiente comando para ver si estan 100% levantados
```bash
docker ps
CONTAINER ID   IMAGE                    COMMAND                  CREATED          STATUS        PORTS                                                                                         NAMES
7e42109de685   caddy:latest             "caddy run --config …"   20 seconds ago   Up 19 seconds             0.0.0.0:80->80/tcp, :::80->80/tcp, 0.0.0.0:443->443/tcp, :::443->443/tcp, 443/udp, 2019/tcp   caddy
60fe3aeab532   louislam/uptime-kuma:1   "/usr/bin/dumb-init …"   20 seconds ago   Up 19 seconds (healthy)   0.0.0.0:3001->3001/tcp, :::3001->3001/tcp                                                     kuma
3041d8080564   php:apache               "docker-php-entrypoi…"   20 seconds ago   Up 19 seconds             80/tcp 
```

## COMPROBAR QUE LAS RUTAS ESTAN BIEN PUESTAS TANTO EN APACHE COMO EN CADDY

```bash
pavon@pavon:~$ docker exec -it apache bash
root@3041d8080564:/var/www/html# cat index.html
ISMAEL PAVON HUETE
root@3041d8080564:/var/www/html# exit
pavon@pavon:~$ docker exec -it caddy sh
/srv # cat /etc/caddy/Caddyfile
cosa.pavon.duckdns.org {
    reverse_proxy apache:80
} 
monitor.pavon.duckdns.org {
    reverse_proxy kuma:3001
} 
```

## AÑADIR TAMBIEN EL CONTENEDOR DE DUCKDNS POR SI ACASO ES NECESARIO QUE SE ACTUALIZE LA IP EN ALGUN MOMENTO 

```bash
services:
  duckdns:
    image: lscr.io/linuxserver/duckdns:latest
    container_name: duckdns
    network_mode: host #optional
    environment:
      - PUID=1000 #optional
      - PGID=1000 #optional
      - TZ=Etc/UTC #optional
      - SUBDOMAINS=redespavon
      - TOKEN=b7b448ca-46a2-45ac-b537-27284aec88a4
      - UPDATE_IP=ipv4 #optional
      - LOG_FILE=false #optional
    volumes:
      - /path/to/duckdns/config:/config #optional
    restart: unless-stopped
```

## OCULTAR CABEZERAS DE APACHE 

- Entramos al contenedor apache

```bash
docker exec -it apache bash 
```

- Actualizamos
```bash
apt update
```
- Instalamos el nano 
```bash
apt install nano 
```

- Editamos el archvio pero solo 3 puntos
```bash
nano /etc/apache2/conf-available/security.conf  
```

- ServerTokens Prod 
- ServerSignature Off  
- TraceEnable Off

## SERVICIO APACHE MONTADO EN VPS 
- comprobamos que si hacemos curl a la ip funciona: A mi no me devuelve nada
```bash
curl http://52.143.178.204 
```

## ACCESIBLE POR RUTA
- Comprobar curl de cosa.redespavon.duckdns.org
```bash
curl https://cosa.redespavon.duckdns.org
```
- resultado
```bash
ISMAEL PAVÓN HUETE   
```

## COMO ENTRAR A APACHE
https://cosa.redespavon.duckdns.org

## COMO ENTRAR A KUMA
https://monitor.redespavon.duckdns.org

## COMO ENTRAR A LA PAGINA DE ESTADO
https://monitor.redespavon.duckdns.org/status/observar