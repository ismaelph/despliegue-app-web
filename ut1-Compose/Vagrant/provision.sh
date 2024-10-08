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

sudo -u vagrant mkdir $HOME/contenedores

sudo -u vagrant cd $HOME/contenedores

cp /vagrant/docker-compose.yml .

chown -R vagrant:vagrant docker-compose.yml

sudo -u vagrant docker compose up -d

sudo -u vagrant mkdir $HOME/public

cd public

echo "<?php phpinfo(); ?>" > /home/public/info.php