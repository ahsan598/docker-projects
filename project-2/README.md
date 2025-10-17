# Multi-Container Web Deployment with Docker Compose

Deploy and orchestrate **Apache** and **Nginx** web servers simultaneously using Docker Compose with real-time content synchronization through bind mounts.


## Overview
This project demonstrates **multi-container orchestration** using Docker Compose to deploy two popular web servers—Apache HTTP Server and Nginx—from a single configuration file. By leveraging **bind mounts**, content updates on the host machine are instantly reflected in both containers without requiring rebuilds or restarts.

### Key Features

- **Multi-container deployment** from a single YAML configuration
- **Independent port mapping** for concurrent server access
- **Real-time content updates** using bind mounts
- **Simplified management** with Docker Compose commands


## Prerequisites

Before starting, ensure you have:
- Ubuntu-based system (local VM or cloud instance)
- Docker Engine and Docker Compose installed
- Basic understanding of YAML syntax
- Sudo privileges on the target machine

### Required Ports

Ensure the following ports are accessible in your firewall or security group:

| Service | Port | Purpose |
|---------|------|---------|
| Apache  | 91   | Apache web server access |
| Nginx   | 92   | Nginx web server access |
| SSH     | 22   | Remote connection |


## Project Structure

```txt
project-directory/
├── docker-compose.yml
├── apache-data/
│ └── index.html
└── nginx-data/
└── index.html
```


## Implementation Guide

### Step 1: Create Project Directories

Set up separate directories for each web server's content:
```sh
# Create directories for web content
mkdir apache-data nginx-data

# Create sample HTML files for Apache & Nginx
echo '<h1>Hello from Nginx Bind Mount!</h1>' > nginx-data/index.html

echo '<h1>Hello from Apache Bind Mount!</h1>' > apache-data/index.html
```

> **Note:** These directories will be mounted into the containers, allowing instant file synchronization.


### Step-2: Create Docker Compose Configuration

Use the `docker-compose.yml` file provided in this project.

#### Configuration Breakdown

| Parameter | Description |
|-----------|-------------|
| `version: '3.8'` | Docker Compose file format version |
| `services` | Defines all containers to be deployed |
| `image` | Specifies the Docker image to use |
| `container_name` | Assigns a friendly name to the container |
| `ports` | Maps host port to container port (host:container) |
| `volumes` | Bind mounts for real-time file synchronization |
| `restart: unless-stopped` | Automatic restart policy for containers |


### Step 3: Deploy Containers

Start both web servers using a single command:
```sh
# Deploy all services in detached mode
sudo docker compose up -d

# Verify both containers are running:
sudo docker ps

# Check service status
docker compose ps
```

![compose-file](/project-2/imgs/compose-file.png)


### Step 4: Access Web Servers

#### Local Access
```sh
# Test Apache
curl http://localhost:91

# Test Nginx
curl http://localhost:92
```

#### Remote Access
Open your browser and navigate to:
```sh
# Apache Server
http://<YOUR_PUBLIC_IP>:91

# Nginx Server
http://<YOUR_PUBLIC_IP>:92
```

Replace `<YOUR_PUBLIC_IP>` with your server's public IP address.

![access-website](/project-2/imgs/access-website.png)


### Step 5: Test Real-Time Updates

Modify content files to see instant changes:
```sh
# Update Apache & Nginx contents
echo '<h1>Updated Apache Content!</h1>' > apache-data/index.html

echo '<h1>Updated Nginx Content!</h1>' > nginx-data/index.html
```

**Refresh your browser**—changes appear immediately without container restarts or rebuilds.

![updated-content](/project-2/imgs/updated-content.png)

> **Key Advantage:** This workflow is ideal for rapid development cycles where content changes frequently.


## Container Management

### Essential Docker Compose Commands
```sh
# Start all services
sudo docker compose up -d

# Stop all services (keeps containers)
sudo docker compose stop

# Stop and remove all containers
sudo docker compose down

# Restart containers
sudo docker compose up -d

# View logs from all services
sudo docker compose logs

# Follow logs in real-time
sudo docker compose logs -f

# View logs for specific service
sudo docker compose logs apache

# Restart all services
sudo docker compose restart

# Rebuild images (if Dockerfile added later)
sudo docker compose up --build -d

# Scale a service (run multiple instances)
sudo docker compose up -d --scale nginx=3
```

### Service-Specific Commands
```sh
# Start only Apache
sudo docker compose up -d apache

# Stop only Nginx
sudo docker compose stop nginx

# Restart specific service
sudo docker compose restart apache

# View resource usage
sudo docker compose stats
```


## Docker Compose Benefits

| Feature | Description | Benefit |
|---------|-------------|---------|
| **Declarative Configuration** | Define infrastructure as YAML code | Version-controlled, reproducible deployments |
| **Multi-Container Orchestration** | Manage multiple services together | Simplified complex application stacks |
| **Dependency Management** | Define service startup order | Ensures proper initialization sequence |
| **Network Isolation** | Automatic service discovery | Secure inter-container communication |
| **Volume Management** | Persistent data and bind mounts | Data survives container recreation |
| **Environment Variables** | Centralized configuration | Easy customization across environments |


## Comparison: Apache vs Nginx

| Feature | Apache | Nginx |
|---------|--------|-------|
| **Architecture** | Process-driven | Event-driven, asynchronous |
| **Performance** | Good for dynamic content | Excellent for static content |
| **Configuration** | `.htaccess` support | Centralized config files |
| **Module System** | Dynamic module loading | Compiled modules |
| **Use Case** | WordPress, PHP applications | Reverse proxy, load balancer |
| **Resource Usage** | Higher memory per connection | Lower memory footprint |


## Troubleshooting

### Port Conflicts
- Check if ports are already in use
```sh
sudo netstat -tlnp | grep ':91|:92'
```
- Change ports in docker-compose.yml
ports: `8091:80` # Use different host port

### Permission Issues
- Fix directory permissions
```sh
sudo chmod -R 755 apache-data nginx-data
```
- Check file ownership
```sh
ls -la apache-data/ nginx-data/
```

### Container Won't Start
- View detailed logs
```sh
sudo docker compose logs apache
sudo docker compose logs nginx
```
- Check container status
```sh
sudo docker compose ps -a
```

### Changes Not Reflecting
- Verify bind mount paths in `docker-compose.yml`
- Ensure files are in the correct directories
- Clear browser cache (Ctrl+Shift+R)
- Check file permissions on host


## Cleanup

Remove all resources created by this project:
```sh
# Stop and remove containers
sudo docker compose down

# Remove containers and volumes
sudo docker compose down -v

# Remove images (optional)
sudo docker rmi httpd:latest nginx:latest
```


## Advanced Configurations

### Add Custom Apache Configuration
```sh
apache:
  image: httpd:latest
  volumes:
    - ./apache-data:/usr/local/apache2/htdocs
    - ./httpd.conf:/usr/local/apache2/conf/httpd.conf
```

### Add Environment Variables
```sh
nginx:
  image: nginx:latest
  environment:
    - NGINX_HOST=example.com
    - NGINX_PORT=80
```

### Add Health Checks
```sh
apache:
  image: httpd:latest
  healthcheck:
    test: ["CMD", "curl", "-f", "http://localhost"]
    interval: 30s
    timeout: 3s
    retries: 3
```


## Key Takeaways

- **Docker Compose** simplifies multi-container application deployment
- **Single configuration file** manages entire application stack
- **Bind mounts** enable real-time content synchronization
- **Port mapping** allows multiple services on the same host
- **Declarative approach** makes infrastructure reproducible and version-controlled
- **Service isolation** ensures independent container management

---

## Additional Resources

- **[Docker Compose Documentation](https://docs.docker.com/compose/):** Official reference for Compose file syntax, commands, and configuration options.
- **[Apache httpd](https://httpd.apache.org/docs/):** Configuration guides, modules reference, and best practices.
- **[Nginx Documentation](https://nginx.org/en/docs/):** Official guide for server configuration, performance tuning, and optimization.
