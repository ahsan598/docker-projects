# Deploy Apache & Nginx Containers using Docker Compose

## Objective
- Use **Docker Compose** to deploy two web servers — **Apache and Nginx** — running as separate containers on the same host machine.
- Each container is exposed on a different port:
  - **Apache → Port 91**
  - **Nginx → Port 92**
- Demonstrates how **multiple services** can be managed together using a single configuration file (`docker-compose.yml`).
- Explore **Bind Mounts** for **live updates**: any changes on the host machine are instantly reflected inside the containers without rebuilding.


## What is a Bind Mount?
A **Bind Mount** links a **host folder** to a **container folder**:
- Changes on host → instantly visible in container.
- Useful for dynamic web content updates.
  
**Example:**
```yaml
volumes:
  - ./nginx-data:/usr/share/nginx/html
```
- Editing any file in `nginx-data` updates Nginx container content automatically.


## Prerequisites
- Ubuntu system (local or AWS instance)
- Docker and Docker Compose installed
- Basic understanding of YAML syntax


## Project Structure

```sh
project-2/
├── docker-compose.yml
├── nginx-data/
│   └── index.html
└── apache-data/
    └── index.html
```

## Steps to Implement

### Step-1: Create Project Folders & Sample Pages

```sh
mkdir apache-data nginx-data

echo "<h1>Hello from Nginx Bind Mount!</h1>" > nginx-data/index.html
echo "<h1>Hello from Apache Bind Mount!</h1>" > apache-data/index.html
```

- Now create `docker-compose.yml` file.
- Use the provided file to deploy Apache & Nginx containers with custom ports and bind mounts.


### Step-2: Deploy Both Containers
- Run the following command in the same directory as your `docker-compose.yml`
```sh
# Start all containers
docker compose up -d

# Verify container is running:
sudo docker ps
```

![compose-up](/project-3/imgs/compose-file.png)

- Open browser:
  - Apache → http://<AWS_PUBLIC_IP>:91
  - Nginx → http://<AWS_PUBLIC_IP>:92

![access-website](/project-3/imgs/access-website.png)

**Note:** The above image shows the default pages served without bind mounts, displaying their respective messages.


### Step-3: AWS Security Group Configuration  (for Apache + Nginx)
**Inbound Rules to Add**
| Type       | Protocol | Port Range | Source              | Description                 |
| ---------- | -------- | ---------- | --------------------| --------------------------- |
| SSH        | TCP      | 22         | *Your Public IP*    | To connect via SSH          |
| Custom TCP | TCP      | 91         | 0.0.0.0/0           | Apache container web access |
| Custom TCP | TCP      | 92         | 0.0.0.0/0           | Nginx container web access  |

![sg-ports](/project-3/imgs/sg-ports.png)


### Step-4: Test Dynamic Content Update
```sh
# Modify your website files on the host:
echo '<h1>Updated Website Content!</h1>' > apache-data/index.html
```
- Refresh the browser → Updated content will instantly reflect inside the container.
- This proves Bind Mount keeps host and container files in sync in real-time.


## Step-5: Manage Containers via Docker Compose
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


## Concept Highlight: Docker Compose
| Feature                | Description                                             |
| ---------------------- | ------------------------------------------------------- |
| **Single Config File** | Manages multiple containers declaratively using YAML    |
| **Port Mapping**       | Maps host ports to container ports easily               |
| **Volume Binding**     | Links local directories to containers for live updates  |
| **Ease of Management** | Start/stop all containers together with simple commands |


## Outcome
- Two web servers deployed using a **single Docker Compose file**
- Apache served content on **Port 91**
- Nginx served content on **Port 92**
- Demonstrated practical use of **multi-container orchestration** using Docker Compose
