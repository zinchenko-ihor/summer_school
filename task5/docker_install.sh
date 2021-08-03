#!/bin/bash

# Update the apt package index and install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package index and install docker-ce
sudo apt-get update
sudo apt-get install -y docker-ce
sudo docker run hello-world
sudo apt-get install -y docker-compose

# Add group and user for docker
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
