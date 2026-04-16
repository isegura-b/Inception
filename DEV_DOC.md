# Developer Documentation

## 1. Design Principles

The system follows a modular container-based architecture:

* Each service runs independently
* Communication is handled via a dedicated Docker network
* Responsibilities are strictly separated

---

## 2. Docker Strategy

* Custom Dockerfiles for each service
* No use of prebuilt application images
* Explicit versioning (Debian Bullseye)

---

## 3. Services

### MariaDB

* Initialized via custom entrypoint script
* Database and users created programmatically
* Initialization guarded by a flag file

---

### WordPress

* Installed and configured using WP-CLI
* Waits for MariaDB availability before setup
* Configuration generated dynamically

---

### NGINX

* Acts as reverse proxy
* Handles TLS termination
* Forwards PHP requests to WordPress (port 9000)

---

## 4. Secrets Handling

Sensitive data is not stored in `.env`.

Instead:

* Docker secrets are mounted at `/run/secrets/`
* Scripts read secrets at runtime

Example:

```bash
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
```

---

## 5. Networking

* Single Docker network: `inception`
* Services resolve each other by container name

---

## 6. Volumes

Bind mounts are used for persistence:

* Ensures data durability
* Allows inspection from host system

---

## 7. Key Implementation Decisions

* Separation of configuration and secrets
* Minimal initialization scripts
* Avoidance of unnecessary complexity
* Emphasis on reproducibility

---

## 8. Possible Improvements

* Healthchecks for service readiness
* Automated backups
* TLS via Let's Encrypt
* Enhanced NGINX security configuration

---

