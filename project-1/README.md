# Containerized Web Deployment with Apache and Bind Mounts

## Objective
The goal of this project is to deploy a custom website inside a Apache container. We will also demonstrate how **dynamic content updates** can be achieved by using **Bind Mounts**, so that changes made on the host machine are instantly reflected inside the container without rebuilding it.

### What is a Bind Mount?
A **Bind Mount** is a way to share a folder between your **host system** and a **Docker container**.
- Changes on your **host machine** → instantly appear inside the container.
- Useful for **dynamic web content** — no need to rebuild the container repeatedly.


## Prerequisites
- Ubuntu system (local or AWS instance)
- Docker installed
- - Make sure the following ports are open in your firewall or AWS Security Group:
  - Apache → 8080
  - SSH → 22


## Steps to Implement:

### Step-1: Download Apache Docker Image
```sh
# Pull Apache (httpd) Docker Image
sudo docker pull httpd:latest

# Verify image is available:
sudo docker images
```

### Step-2: Prepare Host Directory for Website
```sh
# Create a directory on the host for your custom site:
mkdir -p /home/ubuntu/data

# Add an index.html file (Apache serves this by default):
echo '<h1>Hello from Apache in Docker!</h1>' > /home/ubuntu/data/index.html
```

![index-file](/project-1/imgs/index-file.png)


### Step-3: Run Apache Container with Bind Mount
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
![apache](/project-1/imgs/apache.png)

**Breakdown:**
- `-d` → Detached mode (runs in background)
- `-p 8080:80` → Map host port 8080 → container port 80
- `--mount type=bind` → Bind mount host directory
- `source=/home/ubuntu/data` → Host directory containing website files
- `target=/usr/local/apache2/htdocs` → Apache’s web root inside container
- `--name apache` → Assigns name "apache" to container
- `httpd:latest` → Apache HTTP server image

```sh
# Optional verification via curl
curl http://localhost:8080

# Access Apache site in Browser
http://<AWS_PUBLIC_IP>:8080

# Modify your website files on the host:
echo '<h1>Updated Website Content!</h1>' > /home/ubuntu/data/index.html

# Refresh the browser, updated content will instantly reflect inside the container.
```

![updated-content](/project-1/imgs/updated-content.png)

**Note:** Apache container exposes on **port 80** internally, which is mapped to **port 8080** on the host.


## Volume vs Bind Mount
| Feature     | Bind Mount                               | Docker Volume                             |
| ----------- | ---------------------------------------- | ----------------------------------------- |
| Location    | Any path on host filesystem              | Managed by Docker (`/var/lib/docker/...`) |
| Use Case    | Live development, real-time file updates | Persistent storage for databases, logs    |
| Portability | Depends on host path                     | Easily portable across hosts/containers   |
| Management  | Host-controlled                          | Docker-controlled (via CLI/API)           |


## What I learned
- Understood when and why to use **Bind Mounts** in Docker.
- Successfully deployed a website using an **Apache container**.
- Achieved **live (dynamic) updates** without rebuilding the container.
