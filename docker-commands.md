# Docker Command Reference

A comprehensive guide covering essential Docker commands for managing images, containers, volumes, and system resources.


## Image Management
```sh
# Pull (download) the latest apache HTTP server image
sudo docker pull httpd:latest

# List all available docker images
sudo docker images

# List images with digests
sudo docker images --digests

# Remove a specific image
sudo docker rmi httpd:latest

# Remove dangling (unused) images
sudo docker image prune

# Remove all unused images
sudo docker image prune -a
```


## Container Operations
```sh
# Run apache container in detached mode (background) with port mapping
sudo docker run -d -p 8080:80 --name apache httpd:latest

# List running containers
sudo docker ps

# List all containers (running + stopped)
sudo docker ps -a

# Stop a running container
sudo docker stop apache

# Start a stopped container
sudo docker start apache

# Restart a container
sudo docker restart apache

# Remove a container (must be stopped first)
sudo docker rm apache

# Force remove a running container
sudo docker rm -f apache

# Remove all stopped containers
sudo docker container prune
```


## Logs, Inspection and Interactive Access
```sh
# Show container logs
sudo docker logs apache

# Follow container logs in real-time (live stream)
sudo docker logs -f apache

# Show last 100 log lines
sudo docker logs --tail 100 apache

# Inspect detailed info about a container
sudo docker inspect apache

# Show resource usage (CPU, RAM) of running containers
sudo docker stats

# Show resource usage for specific container
sudo docker stats apache

# Access container shell interactively
sudo docker exec -it apache /bin/bash

# Execute a single command inside container
sudo docker exec apache ls /usr/local/apache2/htdocs

# Run command as specific user
sudo docker exec -u root apache whoami
```


## Volume Management
```sh
# List all Docker volumes
sudo docker volume ls

# Create a new volume
sudo docker volume create mydata

# Inspect a volume
sudo docker volume inspect mydata

# Remove a volume
sudo docker volume rm mydata

# Remove all unused volumes
sudo docker volume prune

# Run a container with a named volume
sudo docker run -d -p 8080:80 --name apache -v mydata:/usr/local/apache2/htdocs httpd:latest

# Run container with bind mount (local directory)
sudo docker run -d -p 8080:80 --name apache -v $(pwd)/website:/usr/local/apache2/htdocs httpd:latest
```


## Network Management
```sh
# List all networks
sudo docker network ls

# Create a custom network
sudo docker network create mynetwork

# Inspect network details
sudo docker network inspect mynetwork

# Connect container to network
sudo docker network connect mynetwork apache

# Disconnect container from network
sudo docker network disconnect mynetwork apache

# Remove network
sudo docker network rm mynetwork
```


## System Cleanup
```sh
# Remove unused containers, networks, images (safe cleanup)
sudo docker system prune

# View what would be removed (dry run)
docker system prune --dry-run

# Aggressive cleanup: remove all unused containers, networks, images and volumes
sudo docker system prune -a --volumes

# View disk usage
sudo docker system df
```


## Docker Compose Commands
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

# View resource usage
sudo docker compose stats

# Restart all services
sudo docker compose restart

# Rebuild images (if Dockerfile added later)
sudo docker compose up --build -d

# Scale a service (run multiple instances)
sudo docker compose up -d --scale nginx=3
```


## Quick Reference

| Task | Command |
|------|---------|
| Pull image | `docker pull <image>` |
| Run container | `docker run -d -p <host>:<container> --name <name> <image>` |
| Stop container | `docker stop <container>` |
| View logs | `docker logs -f <container>` |
| Access shell | `docker exec -it <container> /bin/bash` |
| Remove container | `docker rm <container>` |
| Clean system | `docker system prune` |


## Tips and Best Practices

1. **Use named volumes** instead of bind mounts for production data persistence.

2. **Always use specific tags** (e.g., `httpd:2.4`) instead of `latest` for production deployments.

3. **Monitor resources** regularly with `docker stats` to prevent resource exhaustion.

4. **Clean regularly** using `docker system prune` to reclaim disk space.

5. **Use `.dockerignore`** files to exclude unnecessary files from image builds.


---

# Some Advanced Commands

## Docker Search (Docker Hub)
```sh
# Search for images on Docker Hub
docker search nginx

# Search with filter (minimum 50 stars)
docker search --filter stars=50 nginx

# Limit search results to 10
docker search --limit 10 apache

# Search for official images only
docker search --filter is-official=true mysql
```

## Docker Tag (Image Tagging)
```sh
# Tag an image for custom registry
docker tag httpd:latest myregistry.com/httpd:v1.0

# Create alias/tag for local image
docker tag httpd:latest my-apache:production

# Tag for Docker Hub push
docker tag myapp:latest username/myapp:v2.0
```

## Docker Push/Pull (Registry Operations)
```sh
# Push image to Docker Hub
docker push username/myapp:latest

# Push to private registry
docker push myregistry.com/myapp:v1.0

# Pull specific version
docker pull nginx:1.24-alpine

# Pull all tags of an image
docker pull -a nginx
```

## Docker History (Image Layers)
```sh
# Show image build history and layers
docker history httpd:latest

# Show history without truncation
docker history --no-trunc httpd:latest

# Show human-readable sizes
docker history --human httpd:latest
```

## Docker Save/Load (Offline Transfer)
```sh
# Save image to tar file (for offline transfer)
docker save -o apache.tar httpd:latest

# Load image from tar file
docker load -i apache.tar

# Save multiple images
docker save -o myimages.tar httpd:latest nginx:latest
```

## Docker Export/Import (Container Filesystem)

```sh
# Export container filesystem to tar
docker export apache > apache-container.tar

# Import filesystem as image
docker import apache-container.tar my-apache:backup
```

## Docker Commit (Create Image from Container)
```sh
# Create image from modified container
docker commit apache my-custom-apache:v1

# Commit with author and message
docker commit -a "Your Name" -m "Added custom configs" apache my-apache:configured
```

## Docker Top (Process Monitoring)
```sh
# Show running processes inside container
docker top apache

# Show with custom ps format
docker top apache aux
```

## Docker Diff (Filesystem Changes)
```sh
# Show files modified in container
docker diff apache

# Output: A = Added, D = Deleted, C = Changed
```

## Docker CP (Copy Files)
```sh
# Copy file from container to host
docker cp apache:/usr/local/apache2/conf/httpd.conf ./httpd.conf

# Copy file from host to container
docker cp ./index.html apache:/usr/local/apache2/htdocs/

# Copy directory
docker cp ./website/ apache:/usr/local/apache2/htdocs/
```

## Docker Rename
```sh
# Rename a container
docker rename old-name new-name

# Example
docker rename apache apache-prod
```

## Docker Wait
```sh
# Wait for container to stop and get exit code
docker wait apache

# Wait for multiple containers
docker wait container1 container2
```

## Docker Events (Real-time Monitoring)
```sh
# Show real-time Docker events
docker events

# Filter events by type
docker events --filter type=container

# Filter by container name
docker events --filter container=apache
```

## Docker Port (Port Mapping Info)
```sh
# Show port mappings for container
docker port apache

# Show specific port mapping
docker port apache 80
```

## Docker Pause/Unpause
```sh
# Pause all processes in container (freeze)
docker pause apache

# Resume paused container
docker unpause apache
```

## Docker Update (Runtime Config)
```sh
# Update container resource limits
docker update --memory 512m apache

# Update CPU shares
docker update --cpus 2 apache

# Update restart policy
docker update --restart unless-stopped apache
```

## Multi-Stage Builds Info
```sh
# Build with specific target stage
docker build --target production -t myapp:prod .

# Build with build arguments
docker build --build-arg VERSION=1.0 -t myapp .

# Build without cache
docker build --no-cache -t myapp .
```

## Docker Context (Remote Docker)
```sh
# List available contexts
docker context ls

# Create new context for remote Docker
docker context create remote --docker "host=ssh://user@remote-host"

# Switch context
docker context use remote

# Remove context
docker context rm remote
```

## Health Check Commands
```sh
# Run container with health check
docker run -d --name web \
  --health-cmd="curl -f http://localhost/ || exit 1" \
  --health-interval=30s \
  --health-timeout=3s \
  --health-retries=3 \
  nginx

# Check container health status
docker inspect --format='{{.State.Health.Status}}' web
```


## Quick Reference Table

Category  |  Command                                |  Purpose                    
----------|-----------------------------------------|-----------------------------
Search    |  docker search nginx                    |  Search Docker Hub          
Tag       |  docker tag image:tag new-name:tag      |  Rename/tag image           
Push      |  docker push username/image:tag         |  Upload to registry         
History   |  docker history image                   |  Show image layers          
Save      |  docker save -o file.tar image          |  Export image               
Load      |  docker load -i file.tar                |  Import image               
Commit    |  docker commit container new-image      |  Create image from container
Copy      |  docker cp container:/path ./local      |  Copy files                 
Rename    |  docker rename old new                  |  Rename container           
Pause     |  docker pause container                 |  Freeze container           
Top       |  docker top container                   |  Show processes             
Diff      |  docker diff container                  |  Show FS changes            
Port      |  docker port container                  |  Show port mappings         
Events    |  docker events                          |  Monitor real-time events   
Update    |  docker update --memory 512m container  |  Update resources
