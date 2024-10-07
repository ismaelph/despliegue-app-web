apt-get update && apt-get install -y curl

sudo -u vagrant docker --version
if [[ ! $? -eq 0 ]]; then
	sudo -u vagrant curl -fsSL https://get.docker.com -o install-docker.sh
	sh install-docker.sh

	groupadd docker
	usermod -aG docker vagrant
fi
sudo -u vagrant docker --version

ip a | grep "inet "


docker network create mired

docker pull mariadb

docker pull php:apache

docker pull phpmyadmin

sudo mkdir contenedores

cd contenedores

sudo touch docker-compose.yml

sudo cat << 'EOF' > docker-compose.yml
	services:
  mariadb:
    container_name: mariadb_container
    image: mariadb
    networks:
      - mired
    environment:
      - MARIADB_ROOT_PASSWORD=1234
      - MARIADB_USER=pepe
      - MARIADB_PASSWORD=despliegue

  php:
    container_name: php_contenedor
    image: php:apache
    networks:
      - mired
    volumes:
      - /php:/var/www/html
    ports:
      - "80:80"

  phpmyadmin:
    container_name: phpmyadmin_container
    image: phpmyadmin
    networks:
      - mired
    environment:
      - PMA_HOST=mariadb_container
    ports:
      - "8080:80"

networks:
  mired:
    external: true
    name: mired
EOF

docker compose up -d

cd /

sudo mkdir php

cd php

sudo echo "<?php phpinfo(); ?>" > info.php


