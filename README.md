Run with:

```
curl -sSL https://raw.githubusercontent.com/skrassiev/ec2/master/init.sh | sudo sh
curl -sSL https://raw.githubusercontent.com/skrassiev/ec2/master/userinit.sh | sh
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose"
```
