#!/bin/bash

sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx

sudo apt install stress -y
# stress --cpu 1 --timeout 300s

# echo "<h1>Hello World</h1>" | sudo tee /var/www/html/index.html

TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

instance_id=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
echo "<h2>Instance ID:</h2> $instance_id" | sudo tee -a /var/www/html/index.html

ami_id=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/ami-id)
echo "<h2>AMI ID:</h2> $ami_id" | sudo tee -a /var/www/html/index.html

public_ipv4=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
echo "<h2>Public IP:</h2> $public_ipv4" | sudo tee -a /var/www/html/index.html