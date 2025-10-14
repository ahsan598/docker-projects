# Deploy Apache & Nginx Containers using Docker Compose

## Objective
- Deploy two web servers — **Apache and Nginx** — using a single **Docker Compose** file.
- Demonstrate **multi-container** orchestration with Docker Compose.
- Explore **Bind Mounts** for **live updates**: any changes on the host machine are instantly reflected inside the containers without rebuilding.


## Prerequisites
- Ubuntu system (local or AWS instance)
- Docker and Docker Compose installed
- Basic understanding of YAML syntax
- Make sure the following ports are open in your firewall or AWS Security Group:
  - Apache → 91
  - Nginx → 92
  - SSH → 22


## Steps to Implement

### Step-1: Create Project Folders & Sample Pages
```sh
mkdir apache-data nginx-data

echo '<h1>Hello from Nginx Bind Mount!</h1>' > nginx-data/index.html
echo '<h1>Hello from Apache Bind Mount!</h1>' > apache-data/index.html
```

- Configure both containers, ports, and bind mounts using the provided `docker-compose.yml` file.


### Step-2: Deploy Both Containers
```sh
# Start all containers
sudo docker compose up -d

# Verify container is running:
sudo docker ps

# Access Apache site
http://<AWS_PUBLIC_IP>:91

# Access Nginx site
http://<AWS_PUBLIC_IP>:92
```

![compose-file](/project-2/imgs/compose-file.png)
![access-website](/project-2/imgs/access-website.png)


### Step-3: Test Dynamic Content Update
```sh
# Update Apache website content
echo '<h1>Updated Apache Content!</h1>' > apache-data/index.html

# Update Nginx website content
echo '<h1>Updated Nginx Content!</h1>' > nginx-data/index.html

# Refresh your browser, changes will **appear instantly** without rebuilding the container.
```
![updated-content](/project-2/imgs/updated-content.png)

## Manage Containers via Docker Compose
```sh
# Stop all containers
sudo docker compose down

# Restart containers
sudo docker compose up -d

# View container logs
sudo docker compose logs

# Rebuild images (if Dockerfile added later)
sudo docker compose up --build -d
```


## Concept Highlight: Docker Compose
| Feature                | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| **Single Config File** | Define and manage multiple containers declaratively       |
| **Port Mapping**       | Map host ports to container ports for external access     |
| **Volume Binding**     | Link host directories to containers for real-time updates |
| **Ease of Management** | Start, stop, and monitor all containers together          |


## What I Learned
- Deployed **two web servers** using a single **Docker Compose** file.
- Configured **Apache** to serve content on **port 91**.
- Configured **Nginx** to serve content on **port 92**.
- Demonstrated the practical use of **multi-container** orchestration with **Docker Compose**.
