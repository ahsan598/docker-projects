# Docker Installation & Quick Start Guide

This guide provides step-by-step instructions to install **Docker Engine** and **Docker Compose** on **Ubuntu-based systems** and demonstrates running your first container. Use this as a reference for all projects that require Docker.


## Prerequisites
Before you begin, ensure you have
- Ubuntu-based system (local VM or cloud instance)
- Terminal access (SSH, GitBash, or PowerShell)
- Sudo privileges on the target machine

### Required Ports
Ensure the following ports are open in your firewall or security group:

| Service | Port |
|---------|------|
| Apache  | 8080 |
| SSH     | 22   |


## Installation Steps
- An automated installation script `install-docker.sh` is provided to simplify the setup process.

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
![docker-version](/docker-setup/imgs/docker-version.png)


## Post-Installation (Optional)

### Run Docker Without Sudo
To allow non-root users to run Docker commands without `sudo`
```sh
# Add your user to the docker group.
sudo usermod -aG docker $USER  

# Apply group changes immediately
newgrp docker                       
```

> **Note:** Log out and log back in for group changes to take full effect.


## Quick Start Example

### Run Apache Web Server
```sh
# Pull & run an Apache container with latest image
sudo docker run -d -p 8080:80 --name apache httpd:latest

# Verify container is running:
sudo docker ps

# Test Apache response (via curl):
curl http://localhost:8080

# Access Apache site in Browser
http://localhost:8080
```

The Apache server will be accessible at host port 8080 maps to container port 80.

![dokcer-container](/docker-setup/imgs/docker-container.png)


## Troubleshooting

1. **Permission denied errors:** Ensure you've added your user to the docker group or use `sudo`.

2. **Port conflicts:** If port `8080` is already in use, change the host port mapping (e.g., `-p 9090:80`).

3. **Container won't start:** Check logs with `docker logs <container-name>` for error details.
