# Containerized Web Deployment with Apache and Bind Mounts

A practical guide demonstrating how to deploy a custom website using Apache in Docker with **bind mounts** for real-time content updates without container rebuilds.

## Overview
This project showcases deploying a static website inside an Apache HTTP Server container using Docker bind mounts. The key advantage is **dynamic content updates**—any changes made to files on the host machine are instantly reflected in the running container without requiring a rebuild or restart.

### What is a Bind Mount?
A **bind mount** creates a direct link between a directory on your host system and a directory inside a Docker container.

**This enables:**
- **Real-time synchronization**: Changes on the host instantly appear in the container
- **Development efficiency**: No need to rebuild images for content updates
- **Direct file access**: Full control over files from the host filesystem


## Prerequisites
Before starting, ensure you have:

- Ubuntu-based system (local VM or cloud instance)
- Docker Engine installed and running
- Sudo privileges on the target machine

### Required Ports
Ensure the following ports are accessible:
| Service | Port | Purpose |
|---------|------|---------|
| Apache  | 8080 | Web server access |
| SSH     | 22   | Remote connection |


## Implementation Guide

### Step-1: Pull Apache Image

Download the official Apache HTTP Server image from Docker Hub:
```sh
# Pull the latest Apache (httpd) Image
sudo docker pull httpd:latest

# Verify the image is downloaded
sudo docker images
```

### Step-2: Prepare Host Directory

Create a directory on your host machine to store website files:
```sh
# Create website directory
mkdir -p /home/ubuntu/data

# Create a sample index.html file
echo '<h1>Hello from Apache in Docker!</h1>' > /home/ubuntu/data/index.html
```

![index-file](/project-1/imgs/index-file.png)

> **Tip:** You can add any HTML, CSS, or JavaScript files to this directory—they will all be served by Apache.


### Step-3: Run Apache Container with Bind Mount

Launch the Apache container with a bind mount linking your host directory to Apache's web root:
```sh
# Running apache container with bind mount
sudo docker container run -d \
  -p 8080:80 \
  --mount type=bind,source=/home/ubuntu/data,target=/usr/local/apache2/htdocs \
  --name apache \
  httpd:latest

# Verify the container is running:
sudo docker ps
```

![apache](/project-1/imgs/apache.png)

#### Command Breakdown

| Flag | Description |
|------|-------------|
| `-d` | Run container in detached mode (background) |
| `-p 8080:80` | Map host port 8080 to container port 80 |
| `--mount type=bind` | Specify bind mount type |
| `source=/home/ubuntu/data` | Host directory containing website files |
| `target=/usr/local/apache2/htdocs` | Apache's document root inside container |
| `--name apache` | Assign a friendly name to the container |
| `httpd:latest` | Use the latest Apache HTTP Server image |


### Step 4: Access and Verify

#### Local Access
```sh
# Test using curl
curl http://localhost:8080
```

#### Remote Access
- Open your browser and navigate to:
```sh
http://<YOUR_PUBLIC_IP>:8080
```
- Replace `<YOUR_PUBLIC_IP>` with your server's public IP address or domain name.


### Step 5: Test Dynamic Updates

- Modify the website content on the host machine:
```sh
# Update the index.html file
echo '<h1>Updated Website Content!</h1>' > /home/ubuntu/data/index.html
```
- Refresh the browser, updated content will instantly reflect inside the container.

![updated-content](/project-1/imgs/updated-content.png)


> **Key Insight:** This demonstrates the power of bind mounts for development workflows where frequent content changes are needed.


## Bind Mount vs Docker Volume

Understanding when to use each storage option:

| Feature | Bind Mount | Docker Volume |
|---------|------------|---------------|
| **Location** | Any path on host filesystem | Managed by Docker in `/var/lib/docker/volumes/` |
| **Use Case** | Development, real-time file updates | Production data, databases, logs |
| **Portability** | Depends on host path availability | Highly portable across hosts |
| **Management** | Manual host filesystem control | Docker CLI/API managed |
| **Performance** | Direct filesystem access | Optimized by Docker |
| **Best For** | Static sites, config files, development | Persistent app data, stateful services |


### When to Use What

**Use Bind Mounts when:**
- Developing locally and need instant file updates
- Sharing configuration files between host and container
- Working with source code that changes frequently

**Use Docker Volumes when:**
- Running production databases (MySQL, PostgreSQL)
- Storing application logs and persistent data
- Need to share data between multiple containers
- Require backup and migration capabilities


## Troubleshooting

**1. Container won't start:**

Check container logs
```sh
sudo docker logs apache
```
**2. Permission denied errors:**

Fix file permissions
```sh
sudo chmod -R 755 /home/ubuntu/data
```

**3. Port already in use:**

Use a different host port
```sh
docker run -d -p 9090:80 --mount type=bind,source=/home/ubuntu/data,target=/usr/local/apache2/htdocs --name apache httpd:latest
```

**4. Changes not reflecting:**
- Verify the correct directory is mounted
- Check file permissions
- Ensure browser cache is cleared


## Cleanup
To stop and remove the container:
```sh
# Stop the container
sudo docker stop apache

# Remove the container
sudo docker rm apache

# Remove the image (optional)
sudo docker rmi httpd:latest
```


## Key Takeaways
- **Bind mounts** enable real-time content synchronization between host and container
- **No rebuild required** for content updates—changes are instant
- **Ideal for development** workflows with frequent file modifications
- **Direct host access** provides flexibility for managing website files
- **Production considerations**: Use Docker volumes for persistent application data
