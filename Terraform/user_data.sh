
#!/bin/bash



apt update -y
apt install docker.io -y
systemctl start docker
systemctl enable docker
docker pull pranidock/strapi-app:latest
ufw allow 80
ufw allow 1337
docker run -it -p 1337:1337  pranidock/strapi-app:latest


