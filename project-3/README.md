# Drupal & MariaDB using Docker Compose

## Objective
Deploy a **Drupal-10** website with a **MariaDB** database using Docker Compose.

**This project demonstrates:**
 - Multi-container orchestration with Docker Compose
 - Custom Drupal image including Bootstrap theme
 - Persistent volumes for Drupal & database data
 - Lightweight, dependency-free local setup


## Prerequisites
- Ubuntu system (local or AWS instance)
- Docker installed
- Make sure the following ports are open in your firewall or AWS Security Group:
  - Drupal → 8080
  - SSH → 22


## Custom Drupal Image (Dockerfile)
- Builds a custom **Drupal 10** image with a pre-installed Bootstrap theme
- Optimizations included:
  - `--single-branch` and `--depth 1` make cloning faster and lightweight.
  - `rm -rf /var/lib/apt/lists/*` reduces final image size.
  - `chown` ensures Drupal can read/write theme files.

**Note:**
If you mount `/var/www/html` as a volume in Docker Compose, the cloned theme may be overwritten. To prevent this:
- Either mount only `/var/www/html/sites/default/files` for persistent uploads
- Or clone the theme to a host directory and mount that


## Docker Compose Setup
- `docker-compose.yml` defines **Drupal and MariaDB** containers, their persistent volumes, and network configuration
- Orchestrates the full environment and automatically builds the custom Drupal image

**Key volumes:**
- `drupal-data` → Drupal site files
- `db-data` → MariaDB data

**Network:**
- Drupal container connects to MariaDB using hostname `db`


## Running the Project
```sh
# Build and start containers
sudo docker compose up -d

# Access Drupal site
http://<YOUR_HOST_IP>:8080
```

### During Drupal installation:
- Database type: MariaDB
- Database: drupal
- User: drupal
- Password: drupal
- Host: db
- Port: 3306


## Apply Bootstrap Theme:
1. Login to Drupal admin panel
2. Go to Appearance → locate Bootstrap theme
3. Click Install
4. Click Set as default theme
Your site should now use the Bootstrap theme.

**Optional:** Customize the theme settings (colors, layout, typography) via the Appearance → Settings page.


**Persistent Volumes**
Data persists even after stopping the containers:
- `drupal-data` → site files, modules, themes, uploaded content
- `db-data` → database files


## Theme Overview:
**Before Applying Bootstrap Theme**
![before-theme-apply](/project-3/img/before-theme-applied.jpg)

**After Applying Bootstrap Theme**
![after-theme-apply](/project-3/img/after-theme-applied.jpg)


## What I Learned
- Building & extending official Docker images
- Using Docker Compose for multi-service orchestration
- Persistent storage with named volumes
- Applying custom themes in Drupal through Docker
- Understanding volume mounting caveats with cloned themes
- Optimizing image size and permissions
