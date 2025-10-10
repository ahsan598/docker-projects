# 🐳 Docker Installation & Quick Start

This document provides instructions to install **Docker** on **Ubuntu based instances** and run a simple test container.
Use this as a reference for all projects that require Docker.


## Install Docker on Ubuntu based instances
- A bash script `install-docker.sh` is provided in this directory. It automates Docker Engine and Docker Compose installation.
- Execute the script to install Docker
```sh
# Make the script executable
sudo chmod +x install-docker.sh

# Run the script
./install-docker.sh

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
# Run an apache conatiner with latest image
sudo docker container run -d -p 8080:80 --name apache httpd:latest

# Verify container is running:
sudo docker ps
```

## AWS Security Group Configuration
To access your Dockerized Apache website running on an AWS EC2 instance, make sure your Security Group allows the correct inbound traffic.
**Inbound Rules to Add**
| Type                  | Protocol | Port Range | Source              | Description                             |
| --------------------- | -------- | ---------- | ------------------- | ----------------------------------------|
| **SSH**               | TCP      | 22         | *Your Public IP*    | To connect via SSH                      |
| **HTTP (Custom TCP)** | TCP      | 8080       | `0.0.0.0/0`         | To access website in browser            |

**Note:**
- In this project, the Apache container exposes port 80 inside the container, but it’s mapped to port 8080 on the host (-p 8080:80).
- That means the browser will access your site on port 8080 — not 80.
- You can change this mapping if you prefer direct port 80 access.


### Access Website
- Open browser:
  - Apache → http://<AWS_PUBLIC_IP>:8080

**You should see Apache welcome page**


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
