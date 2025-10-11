# Simple Web Server with Docker (Nginx Container)

## Objective
A quick start project to understand three basic ways to run containers:

1. Using `Docker CLI`
2. Using a `Dockerfile`
3. Using `docker-compose.yml`


## Prerequisites
- Ubuntu system (local or AWS instance)
- Docker & Docker compose installed


## Steps to Implement:

### Step-1. Using Docker CLI (without Dockerfile)
- Run Nginx directly with Docker command
```sh
# Run Nginx container on port 8080
sudo docker container run -d -p 8080:80 --name nginx-server nginx:latest

# Check running containers
sudo docker ps
```
![docker-cli](/project-1/imgs/docker-cli.png)

- **Explanation:**
  - `-d` → detached mode
  - `--name nginx-server` → names the container
  - `-p 8080:80` → maps host port 8080 → container port 80
  - `nginx:latest` → official Nginx image

- Open your browser to access → http://localhost:8080


### Step-2 Build a custom image using Dockerfile
- Build & Run from dockerfile
```sh
# Build image
sudo docker build -t my-nginx:1.0 .

# Run container
sudo docker container run -d -p 8081:80 --name nginx-custom my-nginx:1.0
```
![dockerfile](/project-1/imgs/dockerfile.png)

- Open your browser to access → http://localhost:8081


### Step-3 Using Docker Compose
- Start the service
```sh
# Start container via compose
sudo docker compose up -d

# Check containers
sudo docker ps
```
![docker-compose](/project-1/imgs/docker-compose.png)

- Open your browser to access → http://localhost:8082


## Explanation:
- `Docker CLI` example shows using **official image directly**. 
- `Dockerfile` builds a custom Nginx image with a simple HTML page.  
- `docker-compose.yml` builds the same image and maps port 80 → 8080.  
 

## What I Learned
- Pull and run an image directly
- Build your own Docker image
- Use Docker Compose to manage containers
- Map ports for web access


## Cleanup
```sh
# Stop and remove all
sudo docker compose down
sudo docker rm -f nginx-server nginx-custom
sudo docker rmi my-nginx:1.0
```
