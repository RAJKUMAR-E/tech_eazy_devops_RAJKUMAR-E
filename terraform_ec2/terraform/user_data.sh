#!/bin/bash

sudo apt update -y
sudo apt install -y openjdk-21-jdk git nginx

git clone https://github.com/techeazy-consulting/techeazy-devops /opt/app

cd /opt/app
./mvnw clean package

nohup java -jar target/*.jar > /opt/app/app.log 2>&1 &

sudo rm /etc/nginx/sites-enabled/default

cat <<EOF | sudo tee /etc/nginx/sites-available/app
server {
    listen 80;
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/
sudo systemctl restart nginx
