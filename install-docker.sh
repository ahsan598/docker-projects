#!/bin/bash
# ===================================================
# Docker Installation Script for Ubuntu Instances
# Compatible with Ubuntu 20.04, 22.04, 24.04
# ===================================================

# Update package list
sudo apt-get update

# Install required dependencies
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Setup Docker official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository to APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again to include Docker packages
sudo apt-get update

# Install Docker Engine, CLI, containerd, Buildx, Compose
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Optional: Allow non-root user to run docker without sudo
# sudo groupadd docker                # Only needed if 'docker' group doesn't exist
# sudo usermod -aG docker $USER       # Add your user to the docker group.
# newgrp docker                       # To apply group changes

# Verify Docker installation
echo "Verifying Docker installation..."
sudo docker run hello-world
echo "Docker installation completed successfully!"
