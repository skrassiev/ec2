#!/bin/sh
echo Initializing EC2 Amazon Linux or EC2 Ubuntu instance for golang and docker

OS=$(grep '^NAME=' /etc/os-release | awk -F\" '{print $2}')

#package manager
if [ "$OS" == "Ubuntu" ]; then
	PKGM=apt-get
else
	PKGM=yun
fi

#update dist
$PKGM update -y

#install packages we need
$PKGM install -y gcc git openssl-devel.x86-64

#increase ulimits
echo "*               hard    nofile          65536" >>  /etc/security/limits.conf
echo "*               soft    nofile          65536" >>  /etc/security/limits.conf

#install and configure go
curl -sSL https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz | tar -C /usr/local -xvzf -
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

#install docker
if [ "$OS" == "Ubuntu" ]; then
	curl -sSL https://get.docker.com/ubuntu/ | sh
else
	$PKGM install -y docker
fi
service docker start


cat /proc/$(ps auxww|grep docker|grep -v grep | awk '{print $2}')/limits

echo Initialization Done
echo You need to reboot for ulimit to take effect
echo After reboot, restart docker with 'sudo service docker restart'

