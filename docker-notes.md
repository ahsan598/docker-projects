## 3 Ways to Run Containers

| Method             | Tool             | Typical Use Case                            | Example                             |
|--------------------| ---------------- | --------------------------------------------| ----------------------------------- |
| **Direct Command** | `docker run`     | Quick testing, single container setup       | Run Apache or Nginx once            |
| **Dockerfile**     | `docker build`   | Custom image (app + dependencies + config)  | Create custom Apache with HTML site inside      |
| **Docker Compose** | `docker compose` | Multi-container setup, easier orchestration | Apache + DB + Cache + network — all in one YAML    |


## Volume vs Bind Mount
| Feature     | Bind Mount                               | Docker Volume                             |
| ----------- | ---------------------------------------- | ----------------------------------------- |
| Location    | Any path on host filesystem              | Managed by Docker (`/var/lib/docker/...`) |
| Use Case    | Live development, real-time file updates | Persistent storage for databases, logs    |
| Portability | Depends on host path                     | Easily portable across hosts/containers   |
| Management  | Host-controlled                          | Docker-controlled (via CLI/API)           |