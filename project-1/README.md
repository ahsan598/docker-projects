# Deploy a Website in Docker Apache Container

## Objective
The goal of this project is to deploy a custom website inside a Docker Apache container.
We will also demonstrate how dynamic content changes can be achieved by using Bind Mount, so that changes made on the host machine are instantly reflected inside the container without rebuilding it.


## Prerequisites
- Ubuntu instance running on AWS (or any Linux machine)


## Steps to Implement:

### Step-1: Install Docker
- A bash script `install-docker.sh` is provided in the project to automate Docker installation on Ubuntu.

- Execute the script to install Docker
```sh
# Make the script executable
sudo chmod +x install-docker.sh

# Run the script
./install-docker.sh

# Verify installation
sudo systemctl status docker --no-pager

# Verify by running the hello-world image
sudo docker run hello-world
```
**If status shows active (running) → Docker is successfully installed ✅**


### Step-2: Download Apache Docker Image
```sh
# Pull Apache (httpd) Docker Image
sudo docker pull httpd:latest

# Verify image is available:
sudo docker images
```

### Step-3: Prepare Host Directory for Website
```sh
# Create a directory on the host for your custom site:
mkdir -p /home/ubuntu/data

# Add an index.html file (Apache serves this by default):
echo '<h1>Hello from Apache in Docker!</h1>' > /home/ubuntu/data/index.html
```

### Step-4: Run Apache Container with Bind Mount
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


### Step-5: AWS Security Group Configuration
To access your Dockerized Apache website running on an AWS EC2 instance, make sure your Security Group allows the correct inbound traffic.
**Inbound Rules to Add**
| Type                  | Protocol | Port Range | Source              | Description                             |
| --------------------- | -------- | ---------- | ------------------- | ----------------------------------------|
| **SSH**               | TCP      | 22         | *Your Public IP*    | To connect via SSH                      |
| **HTTP (Custom TCP)** | TCP      | 8080       | `0.0.0.0/0`         | To access website in browser (`http://<AWS_PUBLIC_IP>:8080`)  |

**Note:**
- In this project, the Apache container exposes port 80 inside the container, but it’s mapped to port 8080 on the host (-p 8080:80).
- That means the browser will access your site on port 8080 — not 80.
- You can change this mapping if you prefer direct port 80 access.


### Step-6: Access Website
- Open browser:
  - Apache → http://<AWS_PUBLIC_IP>:8080

**You should see your custom website running inside the container 🎉**



### Step-7: Test Dynamic Content Update
```sh
# Modify your website files on the host:
echo '<h1>Updated Website Content!</h1>' > /home/ubuntu/data/index.html
```
- Refresh the browser → Updated content will instantly reflect inside the container.
- This proves Bind Mount keeps host and container files in sync in real-time.


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
