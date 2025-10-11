# Containerized Web Deployment with Apache and Bind Mounts

## Objective
The goal of this project is to deploy a custom website inside a Docker Apache container.
We will also demonstrate how dynamic content changes can be achieved by using Bind Mount, so that changes made on the host machine are instantly reflected inside the container without rebuilding it.


## Prerequisites
- Ubuntu system (local or AWS instance)
- Docker installed (Refer to the [Docker Installation Guide](/docker-installation/readme.md) if needed)


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

# Optional verification via curl
curl http://localhost:8080
```

![apache](/project-1/imgs/apache.png)

**Breakdown:**
- `-d` → Detached mode (runs in background)
- `-p 8080:80` → Map host port 8000 → container port 80
- `--mount type=bind` → Bind mount host directory
- `source=/home/ubuntu/data` → Host directory containing website files
- `target=/usr/local/apache2/htdocs` → Apache’s web root inside container
- `--name apache` → Assigns name "apache" to container
- `httpd:latest` → Apache HTTP server image


### Step-4: AWS Security Group Configuration
To access your Dockerized Apache website running on an AWS EC2 instance, make sure your Security Group allows the correct inbound traffic.
**Inbound Rules to Add**
| Type                  | Protocol | Port Range | Source              | Description                             |
| --------------------- | -------- | ---------- | ------------------- | ----------------------------------------|
| **SSH**               | TCP      | 22         | *Your Public IP*    | To connect via SSH                      |
| **HTTP (Custom TCP)** | TCP      | 8080       | `0.0.0.0/0`         | To access website in browser            |

![sg-ports](/project-1/imgs/sg-ports.png)

**Note:**
- In this project, the Apache container exposes port 80 inside the container, but it’s mapped to port 8080 on the host (-p 8080:80).
- That means the browser will access your site on port 8080 — not 80.
- You can change this mapping if you prefer direct port 80 access.


### Step-5: Access Website
- Open browser:
  - Apache → http://<AWS_PUBLIC_IP>:8080

**You should see your custom website running inside the container 🎉**

### Step-6: Test Dynamic Content Update
```sh
# Modify your website files on the host:
echo '<h1>Updated Website Content!</h1>' > /home/ubuntu/data/index.html
```
- Refresh the browser → Updated content will instantly reflect inside the container.
- This proves Bind Mount keeps host and container files in sync in real-time.

![updated-content](/project-1/imgs/updated-content.png)


## Volume vs Bind Mount
| Feature     | Bind Mount                               | Docker Volume                             |
| ----------- | ---------------------------------------- | ----------------------------------------- |
| Location    | Any path on host filesystem              | Managed by Docker (`/var/lib/docker/...`) |
| Use Case    | Live development, real-time file updates | Persistent storage for databases, logs    |
| Portability | Depends on host path                     | Easily portable across hosts/containers   |
| Management  | Host-controlled                          | Docker-controlled (via CLI/API)           |

**In this project → Bind Mount is used to dynamically update website files.**


## Outcome
- Successfully deployed a website in a Docker **Apache** container
- Achieved dynamic updates without rebuilding container using **Bind Mount**
- Learned difference between **Bind Mount** vs **Volume**
