#!/bin/sh
echo Initializing EC2 Amazon Linux instance for golang and docker

#update
yum update -y

#install packages we need
yum install -y gcc git openssl-devel.x86-64

#increase ulimits
echo "*               hard    nofile          65536" >>  /etc/security/limits.conf
echo "*               soft    nofile          65536" >>  /etc/security/limits.conf

#install and configure go
curl -sSL https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz | tar -C /usr/local -xvzf -
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

#install docker
yum install -y docker
service docker start

echo Initialization Done

