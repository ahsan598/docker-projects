# <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original.svg" alt="Docker" width="40"/> Deploy a Website in Docker Apache Container


### 🎯 Objective
The goal of this project is to deploy a custom website inside a Docker Apache container.
We will also demonstrate how dynamic content changes can be achieved by using Bind Mount, so that changes made on the host machine are instantly reflected inside the container without rebuilding it.

### 🛠️ Prerequisites
- Ubuntu instance running on AWS (or any Linux machine)

### ⚙️ Steps to Implement:

**1️⃣ Install Docker** 

- Create a bash script (install-docker.sh) with the following content:
```sh
#!/bin/bash

# Update package index
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
  
# Update again & install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

- Execute the script to install Docker
```sh
# Make the script executable
sudo chmod +x install-docker.sh

# Run the script
./install-docker.sh

#Verify installation
sudo systemctl status docker --no-pager
```
**If status shows active (running) → Docker is successfully installed ✅**


**2️⃣ Download Apache Docker Image**
```sh
# Pull Apache (httpd) Docker Image
sudo docker pull httpd:latest

# Verify image is available:
sudo docker images
```

**3️⃣ Prepare Host Directory for Website**
```sh
# Create a directory on the host for your custom site:
mkdir -p /home/ubuntu/data

# Add an index.html file (Apache serves this by default):
echo "<h1>Hello from Apache in Docker!</h1>" > /home/ubuntu/data/index.html
```

**4️⃣ Run Apache Container with Bind Mount**
```sh
# Running apache container with bind mount
sudo docker container run -d \
  -p 8080:80 \
  --mount type=bind,source=/home/ubuntu/data,target=/usr/local/apache2/htdocs \
  --name apache \
  httpd:latest

# Verify container is running:
sudo docker ps
```

**Breakdown:**

- `-d` → Detached mode (runs in background)
- `-p 8080:80` → Map host port 8000 → container port 80
- `--mount type=bind` → Bind mount host directory
- `source=/home/ubuntu/data` → Host directory containing website files
- `target=/usr/local/apache2/htdocs` → Apache’s web root inside container
- `--name apache` → Assigns name "apache" to container
- `httpd:latest` → Apache HTTP server image


**5️⃣ Access Website**
```sh
# Open Browser
http://<AWS_PUBLIC_IP>:8080
```
**You should see your custom website running inside the container 🎉**

**6️⃣ Test Dynamic Content Update**
```sh
# Modify your website files on the host:
echo "<h1>Updated Website Content 🚀</h1>" > /home/ubuntu/data/index.html
```
Refresh the browser → Updated content will instantly reflect inside the container.

This proves Bind Mount keeps host and container files in sync in real-time.

---

### 📂 Volume vs Bind Mount
| Feature     | Bind Mount                               | Docker Volume                             |
| ----------- | ---------------------------------------- | ----------------------------------------- |
| Location    | Any path on host filesystem              | Managed by Docker (`/var/lib/docker/...`) |
| Use Case    | Live development, real-time file updates | Persistent storage for databases, logs    |
| Portability | Depends on host path                     | Easily portable across hosts/containers   |
| Management  | Host-controlled                          | Docker-controlled (via CLI/API)           |

**In this project → Bind Mount is used to dynamically update website files.**

### 📌 Useful Docker Commands
```sh
# List running containers
sudo docker ps

# View logs of a container
sudo docker logs apache

# Inspect container details
sudo docker inspect apache

# Stop and remove container
sudo docker stop apache && docker rm apache

# Remove an image
sudo docker rmi httpd:latest
```

### ✅ Outcome
- Successfully deployed a website in a Docker **Apache** container
- Achieved dynamic updates without rebuilding container using **Bind Mount**
- Learned difference between **Bind Mount** vs **Volume**
