# Drupal Compose with MariaDB & Bootstrap

### 🎯 Objective

Set up a Drupal-10 site with a MariaDB backend using Docker Compose. This project demonstrates:
 - Container orchestration with Docker Compose
 - Custom Drupal image with a Bootstrap-based theme
 - Persistent volumes for data
 - No host-level dependencies

> ⚙️ Tools used: Docker, Docker Compose, Git, Drupal, MariaDB

---

### 🚀 Project Overview: Dockerized Drupal with Bootstrap

1. 📦 Dockerfile – Building a Custom Drupal Image
> Keeping layers minimal, cleaning cache, avoiding unnecessary layers (like extra RUN commands), setting correct file permissions, and not installing directly on host.

1. 🧩 docker-compose.yml – Orchestrating Services
> - Used volumes for drupal data and database to persist across restarts.
> - `depends_on` helps with service startup order (though not health-check based).
> - Built `drupal` image from local Dockerfile, tagged as custom-drupal.

---

### Theme Overview:
**Before applying theme to drupal**
![before-theme-apply](https://github.com/ahsan598/devops-projects-hands-on/blob/main/project-3-drupal-docker-compose/img/before-theme-applied.jpg)

**After applying theme to drupal**
![after-theme-apply](https://github.com/ahsan598/devops-projects-hands-on/blob/main/project-3-drupal-docker-compose/img/after-theme-applied.jpg) 

---

### 🛠️ How to Run the Project

```sh
# 1. Build and start the containers
docker compose up -d

# 2. Access the site in your browser
http://localhost:8080

# 3. Follow Drupal's installation wizard (select MariaDB and provide credentials used in docker-compose)

# 4. After setup, go to Appearance > Bootstrap > Install and set as default

# 5. Done! The theme is now applied.

# 6. If you stop the containers:
docker compose down

# This will stop and remove containers, but preserve volumes (data persists)
```

---

### 📚 What I Learned

- Building custom images using Dockerfile
- Multi-container orchestration with docker-compose
- How to persist data using docker volumes
- Installing and applying a drupal theme from git
- Clean image building practices


### ✍️ Notes

- Keep files minimal and clean
- Focus on reusability, clarity, and understanding over production-readiness.

---
<!-- 
### 🙌 Credit
Learned via **Docker Mastery: with Kubernetes + Swarm by @bretfisher** on Udemy. -->
