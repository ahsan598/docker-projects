# 🧱 Project Notes – Drupal + MariaDB with Docker Compose

This document explains how I set up a **Drupal-10 website** using docker compose with a **MariaDB backend**, and how I added a custom **Bootstrap theme** using a Dockerfile.

---

### 🧩 About the Project

This project sets up a **multi-container Drupal CMS** using **Docker Compose**. It includes:

- A **Drupal 10** container running the web application
- A **MariaDB 10.9** container serving as the database backend
- A **Custom Drupal Theme** (Bootstrap) added using a custom-built Docker image


### 📦 Prerequisites

- Docker installed: [Get Docker](https://docs.docker.com/get-docker/)
- Docker Compose v2+


### 🔧 Project Components

1. **`docker-compose.yml`**  
   Defines the services that make up the application (Drupal and MariaDB), allowing them to run together in an isolated and reproducible environment.

2. **`Dockerfile`**  
   Builds a custom Drupal image that pre-installs the Bootstrap theme, enabling visual customization of the site without manual steps.


---

## 🧰 How the Dockerfile Works

This Dockerfile creates a **custom Drupal-10 image** with a pre-installed Bootstrap theme.

### 🔨 Steps Explained:

1. **Use Base Image**
   - Use official Drupal 10.2.7 image (slim variant) as base for a lightweight setup
     ```dockerfile
     FROM drupal:10.2.7-slim
     ```

2. **Install Git**
   - Required to clone the theme from Git:
     ```dockerfile
     RUN apt-get update && \
         apt-get install -y git && \
         rm -rf /var/lib/apt/lists/*
     ```

3. **Change to Themes Directory**
   - This is where Drupal expects themes:
     ```dockerfile
     WORKDIR /var/www/html/themes
     ```

4. **Clone Bootstrap Theme**
   - Cloning a specific branch with shallow history to save space:
     ```dockerfile
     RUN git clone --branch 8.x-4.x --single-branch --depth 1 https://git.drupalcode.org/project/bootstrap.git
     ```

5. **Fix File Permissions**
   - The container runs as `www-data`, but build runs as root, so set correct ownership:
     ```dockerfile
     RUN chown -R www-data:www-data bootstrap
     ```

6. **Reset Working Directory**
   - Back to the default Drupal root:
     ```dockerfile
     WORKDIR /var/www/html
     ```


### 📌 Notes:
- `rm -rf /var/lib/apt/lists/*` cleans up cache after installing git, keeping the image size small.
- Cloning themes at build-time avoids installing git in production containers or manually doing it after container starts.
- Using `chown` instead of another image layer keeps image size optimized.



---

## 🧩 How the Compose File Works

This `docker-compose.yml` file runs both services (Drupal + MariaDB) in an isolated environment.

**1. Services:**

- `drupal`
  - Uses the custom image (custom-drupal)
  - Builds from local Dockerfil
  - Exposes port 8080 → 80 inside container
  - Mounts volumes for persistent Drupal content

- `db`
  - Uses `mariadb:10.9` image
  - Environment variables set for DB init
  - Volume mounted to persist data


**2. Volumes:**

- `drupal-data` → Used to persist Drupal site configuration
- `db-data` → Used to persist MariaDB database files


### 📒 Learnings (So Far)

- Docker networking works differently across compose vs single-container
- Multi-stage builds drastically reduce final image size
- Mounting local volumes makes live dev smoother, but caching gets tricky
- FastAPI + PostgreSQL + Docker Compose is a killer combo for prototyping APIs
- PHP apps with NGINX are simple but need good volume setup for live reloads


### 🌀 Docker Lifecycle Notes

- docker compose down — Removes containers only
- Volumes (drupal-data, db-data) persist between runs
- Next docker compose up will restore site and DB as-is
