# Drupal & MariaDB using Docker Compose

## Objective
Deploy a Drupal 10 website with a MariaDB database using Docker Compose.

**This project demonstrates:**
 - Multi-container orchestration with Docker Compose
 - Custom Drupal image including Bootstrap theme
 - Persistent volumes for Drupal & database data
 - Lightweight, dependency-free local setup


## Prerequisites
- [Docker Engine](https://docs.docker.com/get-docker/)
- [Docker Compose v2+](https://docs.docker.com/compose/install/)


## Custom Drupal Image (Dockerfile)
The **Dockerfile** builds a custom **Drupal 10.2.7** image with a pre-installed **Bootstrap theme**.
It’s included in this project and is automatically used during the Docker Compose build process.

### Notes:
- `--single-branch` and `--depth 1` make cloning faster and lightweight.
- `rm -rf /var/lib/apt/lists/*` reduces final image size.
- `chown` ensures Drupal can read/write theme files.


## Docker Compose Setup
The `docker-compose.yml` file defines both the **Drupal** and **MariaDB** containers, along with their **persistent volumes and network configuration**.
It’s also included in the project and orchestrates the full environment.


## How to Run the Project
```sh
# 1. Build and start containers
docker compose up -d

# 2. Access Drupal
http://localhost:8080

# 3. During Drupal installation:
- Database type: MariaDB
- Host: db
- Database: drupal
- User: drupal
- Password: drupal

# 4. After setup, navigate:
Appearance → Bootstrap → Install → Set as default theme

# 5. Stop containers (data persists)
docker compose down
```

**Persistent Volumes**
- `drupal-data` → Drupal site files
- `db-data` → MariaDB data
> Volumes remain intact after **docker compose down**.


## Theme Overview:
**Before Applying Bootstrap Theme**
![before-theme-apply](https://github.com/ahsan598/docker-projects/blob/main/project-3/img/before-theme-applied.jpg)

**After Applying Bootstrap Theme**
![after-theme-apply](https://github.com/ahsan598/docker-projects/blob/main/project-3/img/after-theme-applied.jpg)


## Learnings
- Building & extending official Docker images
- Using Docker Compose for multi-service orchestration
- Persistent storage with named volumes
- Applying custom themes in Drupal through Docker
- Optimizing image size and permissions


## Notes
- Use minimal layers in Dockerfile for efficiency
- Volumes persist site and database data
- Re-run `docker compose up` to restore previous state
- Project focused on learning — not production security
