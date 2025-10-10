# 🐳 Docker Installation & Quick Start

This document provides instructions to install **Docker** on **Ubuntu** and run a simple test container.
Use this as a reference for all projects that require Docker.


## Install Docker on Ubuntu based instances
- A bash script `install-docker.sh` is provided in this directory. It automates Docker Engine and Docker Compose installation.

- Execute the script to install Docker
```sh
# Make the script executable
sudo chmod +x install-docker.sh

# Run the script
./install-docker.sh

# Verify Docker installation
sudo docker --version
sudo docker compose version


# Verify by running the hello-world image
sudo docker run hello-world
```
If the output shows **"Hello from Docker!"**, Docker is installed successfully.


## Optional: Allow non-root user to run docker without sudo
```sh
sudo groupadd docker                # Only needed if 'docker' group doesn't exist
sudo usermod -aG docker $USER       # Add your user to the docker group.
newgrp docker                       # To apply group changes
```
**Note:** You may need to log out and log back in for group changes to take effect.


## Download & Run Apache Container
```sh
# Run an Apache container with latest image
sudo docker container run -d -p 8080:80 --name apache httpd:latest

# Verify container is running:
sudo docker ps

# Verification via curl (local machine):
curl http://localhost:8080
```
**Note:** Host port 8080 maps to container port 80, so you access it via http://localhost:8080


## Some useful Docker Commands
```sh
# List running containers
sudo docker ps

# List all available docker images
sudo docker images

# Remove an image
sudo docker rmi httpd:latest

# Stop a running container
sudo docker stop apache

# Start a stopped container
sudo docker start apache

# Remove a container (must be stopped first)
sudo docker rm apache

# View logs of a container
sudo docker logs apache

# Inspect container details
sudo docker inspect apache

# Show resource usage (CPU, RAM) of running containers
sudo docker stats

# Remove unused containers, networks, images (safe cleanup)
sudo docker system prune
```
