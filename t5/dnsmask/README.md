# LDAP

- Instalamos Dnsmask con un compose

[docker-compose](./docker/docker-compose.yml)

- Creamos con touch el archivo 

```bash
sudo touch dnsmasq.conf
```

- Ejecutamos el siguiente comando

```bash
docker exec -it dnsmasq-dns-1 cat /etc/dnsmasq.conf > dnsmasq.conf
``` 

```bash
address=/profesor.local/192.168.60.100
address=/youtube.com/127.0.0.1
address=/marca.com/127.0.0.1

address=/ut4.midominio.duckdns.org/10.0.0.100
```

``` Reconfiguramos algunas cosas del ldap