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

docker run -d --net=mired -e MARIADB_ROOT_PASSWORD=1234 -e MARIADB_USER=pepe -e MARIADB_PASSWORD=despliegue --name mariadb_container mariadb

docker run -d --name php_contenedor --net=mired -v /php:/var/www/html -p80:80 php:apache

docker run -d --name phpmyadmin_container --net=mired -e PMA_HOST=mariadb_container -p 8080:80 phpmyadmin

cd /

sudo mkdir php

cd php

sudo echo "<?php phpinfo(); ?>" > info.php

