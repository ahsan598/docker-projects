# Deploy Apache & Nginx Containers using Docker Compose

### 🎯 Objective
In this project, we will use **Docker Compose** to deploy two web servers — **Apache (httpd)** and **Nginx** — running as separate containers on the same host machine.

Each container will be exposed on a different port:
- **Apache → Port 91**
- **Nginx → Port 92**

This setup demonstrates how **multiple services** can be managed together using a single configuration file (`docker-compose.yml`).


### 🛠️ Prerequisites
- Docker and Docker Compose installed
- Basic understanding of YAML syntax
- Ubuntu system (local or AWS instance)


### ⚙️ Steps to Implement

**Step-1: Install Docker & Docker Compose**
- If Docker is not installed, use your previous installation script (`install-docker.sh`) with **Docker Compose plugin**.
- Verify compose version by running below command
```sh
docker compose version
```

**Step-2 Create `docker-compose.yml` File**
```sh
version: '3.9'   # Compose file format version

services:
  apache:
    image: httpd:latest                     # Apache HTTP Server image
    container_name: apache_server           # Container name
    ports:
      - "91:80"                             # Host port 91 → Container port 80
    volumes:
      - ./apache-data:/usr/local/apache2/htdocs  # Bind mount for Apache content

  nginx:
    image: nginx:latest                     # Nginx Server image
    container_name: nginx_server            # Container name
    ports:
      - "92:80"                             # Host port 92 → Container port 80
    volumes:
      - ./nginx-data:/usr/share/nginx/html  # Bind mount for Nginx content
```

**Step-3: Deploy Both Containers**
- Run the following command in the same directory as your `docker-compose.yml`
```sh
docker compose up -d
```

**This will:**
- Pull both images (httpd, nginx)
- Create and start both containers
- Map ports 91 and 92 to the host

**Step-4: Verify the Deployment**
- Check running container:
```sh
docker ps
```
- Access in browser:
  - Apache → http://<HOST_IP>:91
  - Nginx → http://<HOST_IP>:92
- You should see their respective messages.

### Manage Containers via Docker Compose
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

### Concept Highlight: Docker Compose
| Feature                | Description                                             |
| ---------------------- | ------------------------------------------------------- |
| **Single Config File** | Manages multiple containers declaratively using YAML    |
| **Port Mapping**       | Maps host ports to container ports easily               |
| **Volume Binding**     | Links local directories to containers for live updates  |
| **Ease of Management** | Start/stop all containers together with simple commands |


### Outcome
- Two web servers deployed using a **single Docker Compose file**
- Apache served content on **Port 91**
- Nginx served content on **Port 92**
- Demonstrated practical use of **multi-container orchestration** using Docker Compose
