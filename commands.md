# Basic Docker Commands

### Docker Images
```sh
# Pull (download) the latest apache HTTP server image
sudo docker pull httpd:latest

# List all available docker images
sudo docker images

# Remove a specific image
sudo docker rmi httpd:latest

# Remove dangling (unused) images
sudo docker image prune

# Remove all unused images
sudo docker image prune -a
```

### Docker Containers
```sh
# Run apache container in background with port mapping and a name
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
```

### Docker Logs & Info
```sh
# Show container logs
sudo docker logs apache

# Follow container logs in real-time (like tail -f)
sudo docker logs -f apache

# Inspect detailed info about a container
sudo docker inspect apache

# Show resource usage (CPU, RAM) of running containers
sudo docker stats

# Access container shell interactively
sudo docker exec -it apache /bin/bash
```

### Docker Volumes
```sh
# List all Docker volumes
sudo docker volume ls

# Create a new volume
sudo docker volume create mydata

# Run a container with a mounted volume
sudo docker run -d -p 8080:80 --name apache -v mydata:/usr/local/apache2/htdocs httpd:latest

# Inspect a volume
sudo docker volume inspect mydata

# Remove a volume
sudo docker volume rm mydata

# Remove all unused volumes
sudo docker volume prune
```

### Delete / Cleanup
```sh
# Remove unused containers, networks, images (safe cleanup)
sudo docker system prune

# Aggressive cleanup: remove all unused containers, networks, images, volumes
sudo docker system prune -a --volumes
```
