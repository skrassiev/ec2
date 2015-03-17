#!/bin/sh
echo Initializing EC2 Amazon Linux or EC2 Ubuntu instance for golang and docker

OS=$(grep '^NAME=' /etc/os-release | awk -F\" '{print $2}')
OS1=$(cat /etc/redhat-release | awk '{print $1 $2 $3}')

#package manager
if [ "$OS" = "Ubuntu" ]; then
	PKGM=apt-get
	OPENSSL_DEV=libssl-dev 
else
	PKGM=yum
	OPENSSL_DEV=openssl-devel.x86_64
fi

#update dist
$PKGM update -y

#install packages we need
$PKGM install -y gcc git $OPENSSL_DEV

#increase ulimits
# echo "*               hard    nofile          65536" >>  /etc/security/limits.conf
# echo "*               soft    nofile          65536" >>  /etc/security/limits.conf

#install and configure go
# curl -sSL https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz | tar -C /usr/local -xvzf -
# echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

#install docker
if [ "$OS" = "Ubuntu" ]; then
	curl -sSL https://get.docker.com/ubuntu/ | sh
	service docker start
elif [ "$OS1" = "RedHatEnterprise" ]; then
	$PKGM install -y docker-io --enablerepo=epel
	service docker start
	chkconfig docker on
else
	$PKGM install -y docker-io
	service docker start
	chkconfig docker on
fi

cat /proc/$(ps auxww|grep docker|grep -v grep | awk '{print $2}')/limits

#install Docker-compose
curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo Initialization Done
echo You need to reboot for ulimit to take effect
echo After reboot, restart docker with 'sudo service docker restart'

