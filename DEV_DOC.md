# Developer Documentation

## Prerequisites

Required software:

- Docker
- Docker Compose
- GNU Make

Verify installation:

```bash
docker --version
docker compose version
make --version
```

---

## Project Structure

```text
srcs/
├── docker-compose.yml
├── .env
├── secrets/
└── requirements/
    ├── mariadb/
    ├── nginx/
    └── wordpress/
```

Each service contains its own:

- Dockerfile
- configuration files
- startup scripts

---

## Setup

Clone repository:

```bash
git clone <repository>
cd Inception
```

Start infrastructure:

```bash
make
```

---

## Makefile Commands

Build and start:

```bash
make
```

Start in foreground:

```bash
make up
```

Stop services:

```bash
make down
```

Rebuild:

```bash
make re
```

Remove containers, volumes and images:

```bash
make clean
```

Complete cleanup:

```bash
make fclean
```

---

## Docker Compose

Build manually:

```bash
docker compose -f srcs/docker-compose.yml up --build
```

Stop manually:

```bash
docker compose -f srcs/docker-compose.yml down
```

Display logs:

```bash
docker compose -f srcs/docker-compose.yml logs
```

---

## Networking

All services are connected through the Docker network:

```text
inception
```

Service discovery uses Docker DNS.

Examples:

- wordpress connects to mariadb using hostname `mariadb`
- nginx connects to wordpress using hostname `wordpress`

---

## Data Persistence

Persistent data is stored outside containers:

```text
/home/isegura/data/mariadb
/home/isegura/data/wordpress
```

This prevents data loss when containers are recreated.

---

## Secrets

Sensitive data is stored using Docker secrets:

```text
srcs/secrets/
```

Runtime access:

```bash
cat /run/secrets/db_password
```

No passwords are stored directly inside container images.

---

## Development Notes

Design goals:

- Service isolation
- Reproducibility
- Persistent storage
- Secure secret management
- TLS-enabled web access

The infrastructure follows a multi-container architecture using Docker Compose.
