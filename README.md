# Inception — 42 Barcelona

## 1. Overview

This project consists of deploying a containerized infrastructure using Docker. The system is composed of multiple services, each running in its own container and interconnected through a Docker network.

The architecture includes:

* NGINX (web server with TLS)
* WordPress (PHP application)
* MariaDB (database)

---

## 2. Architecture

External requests are handled exclusively through NGINX over HTTPS (port 443). NGINX forwards PHP requests to WordPress (PHP-FPM), which interacts with MariaDB for data persistence.

Flow:

Client → NGINX (TLS) → WordPress (PHP-FPM) → MariaDB

---

## 3. Project Structure

```bash
.
├── Makefile
├── srcs/
│   ├── docker-compose.yml
│   ├── .env
│   ├── secrets/
│   └── requirements/
│       ├── mariadb/
│       ├── nginx/
│       └── wordpress/
```

---

## 4. Configuration

### Environment variables

The `.env` file contains non-sensitive configuration such as:

* Domain name
* Database name
* WordPress metadata

Sensitive data (passwords) is handled via Docker secrets.

---

## 5. Secrets Management

Credentials are stored in:

```
srcs/secrets/
```

Examples:

* db_password.txt
* db_root_password.txt
* wp_admin_password.txt
* wp_user_password.txt

These are mounted at runtime inside `/run/secrets/`.

---

## 6. Volumes

Persistent data is stored outside containers using bind mounts:

* `/home/isegura/data/mariadb`
* `/home/isegura/data/wordpress`

This ensures data is preserved across container rebuilds.

---

## 7. Usage

### Build and start

```bash
make
```

or:

```bash
sudo docker compose -f srcs/docker-compose.yml up --build
```

---

### Stop services

```bash
sudo docker compose -f srcs/docker-compose.yml down
```

---

### Full cleanup

```bash
sudo docker compose -f srcs/docker-compose.yml down -v
sudo rm -rf /home/isegura/data/*
```

---

## 8. Access

Application is available at:

```
https://isegura.42.fr
```

Note: The TLS certificate is self-signed.

---

## 9. Technical Constraints

* No use of `latest` tags
* Services built from custom Dockerfiles
* Debian Bullseye used as base image
* Containers are isolated and communicate via Docker network

---

## 10. Status

* Services are fully operational
* Data persistence is correctly implemented
* Secure credential management via Docker secrets
* HTTPS enabled through TLS

---

