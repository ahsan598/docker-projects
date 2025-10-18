# Drupal CMS with MariaDB using Docker Compose

Deploy a production ready **Drupal 10** content management system with **MariaDB** database backend using Docker Compose, featuring a custom Bootstrap theme and persistent data storage.


## Overview
This project demonstrates a complete **multi-container application** deployment using Docker Compose. It includes a custom-built Drupal image with pre-installed Bootstrap theme, MariaDB database for content storage, and persistent volumes to ensure data survives container restarts.

### Key Features
- **Custom Drupal 10 image** with pre-installed Bootstrap theme
- **MariaDB database** for robust data persistence
- **Named volumes** for Drupal files and database storage
- **Optimized Docker image** with reduced size and proper permissions
- **Simple orchestration** via single docker-compose.yml file
- **Production-ready** configuration with isolated networking


## Prerequisites
Before starting, ensure you have:
- Ubuntu-based system (local VM or cloud instance)
- Docker Engine and Docker Compose installed
- Minimum 2GB RAM and 10GB disk space
- Sudo privileges on the target machine

### Required Ports
Ensure the following ports are accessible:

| Service | Port | Purpose |
|---------|------|---------|
| Drupal  | 8080 | Web interface access |
| SSH     | 22   | Remote connection |

> **Note:** MariaDB runs on the internal Docker network and doesn't require external port exposure.


## Project Structure
```txt
project-directory/
├── Dockerfile
├── docker-compose.yml
└── README.md
```


## Custom Drupal Image
The project includes a custom Dockerfile that extends the official Drupal 10 Apache image with a pre-installed Bootstrap theme for enhanced design capabilities.

### Optimization Highlights
The Dockerfile implements several optimization techniques to reduce image size and improve build performance:

| Optimization | Purpose | Benefit |
|--------------|---------|---------|
| `--single-branch` | Clone only the 8.x-4.x branch | Faster download, smaller footprint |
| `--depth 1` | Fetch only the latest commit | Reduces clone size by ~70% |
| `rm -rf /var/lib/apt/lists/*` | Remove APT package cache | Reduces final image size |
| `chown www-data:www-data` | Set proper file ownership | Ensures Drupal can read/write theme files |

Refer to the `Dockerfile` in this repository for complete implementation details.


### Volume Strategy
This project uses a **targeted volume mounting approach** to preserve the pre-installed Bootstrap theme while maintaining data persistence:

```txt
volumes:
  drupal-data:/var/www/html/themes/contrib/bootstrap
```

**Why this approach:**
- Bootstrap theme from Dockerfile persists across container restarts
- Theme customizations and updates are saved in the named volume
- Core Drupal files remain in the container image (immutable)
- Simpler than mounting the entire `/var/www/html` directory

> **Note:** If you need to mount additional directories (modules, sites, profiles), add separate volume entries in the docker-compose.yml file.


## Docker Compose Configuration
The `docker-compose.yml` file orchestrates the multi-container application stack, defining services, volumes, networking, and environment variables.

### Configuration Breakdown

| Component | Description | Purpose |
|-----------|-------------|---------|
| `build: .` | Builds custom image from Dockerfile in current directory | Includes pre-configured Bootstrap theme |
| `image: drupal-bootstrap:v1.0` | Tags the built image for easy identification | Enables version control and reusability |
| `depends_on: db` | Ensures MariaDB starts before Drupal | Prevents database connection errors during startup |
| `drupal-data` volume | Named volume for Bootstrap theme persistence | Preserves theme files across container lifecycles |
| `db-data` volume | Named volume for database storage | Ensures data survives container restarts |
| `restart: unless-stopped` | Automatic restart policy | Provides high availability and fault tolerance |
| `DRUPAL_DATABASE_HOST=db` | Database connection hostname | Uses Docker's internal DNS for service discovery |


### Network Isolation
Docker Compose automatically creates an isolated bridge network for secure inter-service communication:

- **Drupal** connects to **MariaDB** using the service name `db` as hostname
- **MariaDB** is not exposed to external networks (secure by default)
- Only **Drupal's port 8080** is accessible from the host machine
- All inter-container traffic remains within the private Docker network

This network architecture follows security best practices by minimizing attack surface and preventing direct database access from outside the container environment.


### Environment Variables
The Drupal service includes pre-configured environment variables that simplify the installation process:
```txt
environment:
  - DRUPAL_DATABASE_HOST=db
  - DRUPAL_DATABASE_NAME=drupal
  - DRUPAL_DATABASE_USERNAME=drupal
  - DRUPAL_DATABASE_PASSWORD=root
```

These variables provide the database connection details to Drupal during installation, reducing manual configuration steps.

Refer to the `docker-compose.yml` file in this repository for the complete configuration.


## Deployment Guide

### Step 1: Build and Start Services
```sh
# Build custom drupal image and start all services
sudo docker compose up -d --build

# Verify both containers are running
sudo docker ps

# Check service status
sudo docker compose ps

# Check service logs
sudo docker compose logs -f

# Verify Bootstrap theme is installed (optional check)
sudo docker exec drupal-app ls -la /var/www/html/themes/contrib/bootstrap
```

> **Note:** The `--build` flag ensures the custom Dockerfile is executed and the Bootstrap theme is properly installed.


### Step 2: Access Drupal
Open your browser and navigate to:
```txt
# For cloud/remote deployment:
http://<YOUR_HOST_IP>:8080

# For local development:
http://localhost:8080
```

You will be redirected to the Drupal installation wizard automatically.


## Drupal Installation Wizard
Complete the following steps to configure your Drupal site:

### Step 1: Choose Language
- Select your preferred installation language (English is recommended).
- Click **Save and continue**.

### Step 2: Choose Installation Profile
- Select **Standard** for a fully-featured Drupal site with commonly used modules pre-installed.
- Click **Save and continue**.

### Step 3: Verify Requirements
Drupal will automatically check system requirements. If all checks pass, you'll proceed to database configuration.

### Step 4: Database Configuration
- Enter the following database connection details exactly as shown:
- Enter the following connection details:

| Field | Value |
|-------|-------|
| Database type | MariaDB, MySQL, or equivalent |
| Database name | `drupal` |
| Database username | `drupal` |
| Database password | `drupal` |

#### Advanced Options:
Click **Advanced Options** and enter:

| Field | Value |
|-------|-------|
| Host | `db` |
| Port | `3306` |

> **Important:** The hostname `db` matches the MariaDB service name in `docker-compose.yml`. Docker's internal DNS automatically resolves this to the database container's IP address.

- Click **Save and continue**.


### Step 5: Install Drupal
Drupal will now:
- Create database tables
- Install core modules
- Configure default settings

- This process typically takes **2-3 minutes**. Do not close your browser during installation.


### Step 6: Configure Site Information
- Once installation completes, configure your site details:

| Field | Description | Example |
|-------|-------------|---------|
| **Site name** | Your website's display name | My Drupal Site |
| **Site email address** | Email for system notifications | admin@example.com |
| **Username** | Admin account username | admin |
| **Password** | Strong admin password | Use a secure password |
| **Confirm password** | Re-enter password | (same as above) |
| **Email address** | Admin account email | admin@example.com |

#### Default Country & Timezone

- **Default country:** Select your country
- **Default timezone:** Select your timezone

- Click **Save and continue**.


### Step 7: Installation Complete

Congratulations! Your Drupal site is now installed and ready to use.

You'll be automatically logged in to the admin dashboard.

**Next steps:**
- Apply the Bootstrap theme (see next section)
- Create your first content
- Configure site settings


## Apply Bootstrap Theme

### Step 1: Access Admin Panel
```sh
http://<YOUR_HOST_IP>:8080/user/login
```

Log in with your admin credentials.

### Step 2: Navigate to Appearance

1. Click **Appearance** in the admin toolbar
2. Locate **Bootstrap** in the available themes list
3. Click **Install** next to Bootstrap theme
4. Click **Install and set as default**

### Step 3: Configure Theme (Optional)

Customize your site's appearance:

1. Go to **Appearance** → **Settings**
2. Click **Bootstrap** theme settings
3. Customize:
   - **Color scheme** (primary, secondary colors)
   - **Layout options** (sidebar position, width)
   - **Typography** (font families, sizes)
   - **Component settings** (navbar style, button styles)


## Theme Comparison:
**Before Applying Bootstrap Theme**
![before-theme-apply](/project-3/img/before-theme-applied.jpg)
**After Applying Bootstrap Theme**
![after-theme-apply](/project-3/img/after-theme-applied.jpg)


## Data Persistence

### Named Volumes

This project uses Docker named volumes to ensure data persists across container lifecycles:

| Volume | Mount Point | Contents |
|--------|-------------|----------|
| `drupal-data` | `/var/www/html` | Site files, modules, themes, uploads, configurations |
| `db-data` | `/var/lib/mysql` | MariaDB database files, tables, indexes |


### Volume Management
```sh
# List all volumes
sudo docker volume ls

# Inspect Drupal data volume
sudo docker volume inspect drupal-bootstrap_drupal-data

# Inspect database volume
sudo docker volume inspect drupal-bootstrap_db-data

# Backup Drupal files
sudo docker run --rm -v drupal-bootstrap_drupal-data:/data -v $(pwd):/backup ubuntu tar czf /backup/drupal-backup.tar.gz /data

# Backup database
sudo docker exec drupal_db mysqldump -u drupal -pdrupal drupal > drupal-db-backup.sql
```

### Data Persistence Testing
```sh
# Stop and remove containers
sudo docker compose down

# Data still exists in volumes
sudo docker volume ls

# Restart containers - data persists
sudo docker compose up -d
```


### Database Management
```sh
# Access MariaDB shell
sudo docker exec -it drupal_db mysql -u drupal -pdrupal

# Execute SQL query
sudo docker exec drupal_db mysql -u drupal -pdrupal -e "SHOW DATABASES;"

# Backup database
sudo docker exec drupal_db mysqldump -u drupal -pdrupal drupal > backup.sql

# Restore database
sudo docker exec -i drupal_db mysql -u drupal -pdrupal drupal < backup.sql
```


## Troubleshooting

### 1. Drupal Can't Connect to Database

**Symptom:** Error during installation about database connection

**Solution:**
```sh
# Check if MariaDB is running
sudo docker compose ps

# View database logs
sudo docker compose logs db

# Verify environment variables
sudo docker compose config
```

### 2. Theme Not Appearing

**Symptom:** Bootstrap theme not visible in Appearance section

**Solution:**
```sh
# Check if theme exists in container
sudo docker exec drupal_web ls -la /var/www/html/themes/contrib/

# Rebuild image if missing
sudo docker compose build --no-cache
sudo docker compose up -d
```

### 3. Port Already in Use

**Symptom:** Error binding to port 8080

**Solution:**
```sh
# Check what's using port 8080
sudo netstat -tlnp | grep :8080

# Change port in docker-compose.yml
ports:
  "8081:80"
```

### 4. Permission Issues

**Symptom:** Drupal can't write files

**Solution:**
```sh
# Fix permissions inside container
sudo docker exec drupal_web chown -R www-data:www-data /var/www/html

sudo docker exec drupal_web chmod -R 755 /var/www/html
```

### 5. Volume Data Not Persisting

**Symptom:** Data lost after restart

**Solution:**
```sh
# Verify volumes exist
sudo docker volume ls | grep drupal

# Don't use 'docker compose down -v' (removes volumes)
Use 'sudo docker compose down' instead
```


## ## Key Takeaways
- **Multi-container orchestration** simplified with Docker Compose
- **Custom Docker images** enable pre-configured application deployments
- **Named volumes** ensure data persistence across container lifecycles
- **Service dependencies** manage startup order automatically
- **Image optimization** techniques reduce size and improve build times
- **Network isolation** provides security between services
- **Environment variables** configure applications without code changes
