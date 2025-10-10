# Deploy Apache & Nginx Containers using Docker Compose

## Objective
In this project, we will use **Docker Compose** to deploy two web servers — **Apache (httpd)** and **Nginx** — running as separate containers on the same host machine.

Each container will be exposed on a different port:
- **Apache → Port 91**
- **Nginx → Port 92**

This setup demonstrates how **multiple services** can be managed together using a single configuration file (`docker-compose.yml`).


## Prerequisites
- Docker and Docker Compose installed
- Basic understanding of YAML syntax
- Ubuntu system (local or AWS instance)


## Steps to Implement

### Step-1: Install Docker & Docker Compose
- If Docker is not installed, use previous installation script (`install-docker.sh`) with **Docker Compose plugin**.
- Verify compose version by running below command
```sh
docker compose version
```

### Step-2: Create `docker-compose.yml` File
A `docker-compose.yml` file is provided in the project to deploy Apache and Nginx containers with custom ports and bind mounts.

### Step-3: Deploy Both Containers
- Run the following command in the same directory as your `docker-compose.yml`
```sh
docker compose up -d

# Verify container is running:
sudo docker ps
```
**This will:**
- Pull both images (httpd, nginx)
- Create and start both containers
- Map ports 91 and 92 to the host

### Step-4: AWS Security Group Configuration (for Apache + Nginx Compose Project)
**Inbound Rules to Add**
| Type       | Protocol | Port Range | Source              | Description                 |
| ---------- | -------- | ---------- | --------------------| --------------------------- |
| SSH        | TCP      | 22         | *Your Public IP*    | To connect via SSH          |
| Custom TCP | TCP      | 91         | 0.0.0.0/0           | Apache container web access |
| Custom TCP | TCP      | 92         | 0.0.0.0/0           | Nginx container web access  |


### Step-5: Access Website
- Open browser:
  - Apache → http://<AWS_PUBLIC_IP>:91
  - Nginx → http://<AWS_PUBLIC_IP>:92
- You should see their respective messages.


## Manage Containers via Docker Compose
```sh
# Stop all containers
docker compose down

# Restart containers after update
docker compose up -d

# View logs
docker compose logs

# Rebuild images (if Dockerfile is added later)
docker compose up --build -d
```

## Concept Highlight: Docker Compose
| Feature                | Description                                             |
| ---------------------- | ------------------------------------------------------- |
| **Single Config File** | Manages multiple containers declaratively using YAML    |
| **Port Mapping**       | Maps host ports to container ports easily               |
| **Volume Binding**     | Links local directories to containers for live updates  |
| **Ease of Management** | Start/stop all containers together with simple commands |


## Outcome
- Two web servers deployed using a **single Docker Compose file**
- Apache served content on **Port 91**
- Nginx served content on **Port 92**
- Demonstrated practical use of **multi-container orchestration** using Docker Compose
