*This project has been created as part of the Inception project by isegura*

# Inception

## Description

Inception is a system administration project focused on containerization using Docker.

The infrastructure is composed of three isolated services:

- NGINX
- WordPress
- MariaDB

Each service runs inside its own container and communicates through a dedicated Docker network. Persistent data is stored using Docker volumes.

---

## Instructions

### Build and start

```bash
make
```

### Stop services

```bash
make down
```

### Restart

```bash
make re
```

### Full cleanup

```bash
make fclean
```

---

## References

- Docker Documentation
- Docker Compose Documentation
- NGINX Documentation
- MariaDB Documentation
- WordPress Documentation
- Debian Bullseye Documentation

---

## AI Usage

Artificial Intelligence tools were used as learning assistants to:

- Clarify Docker concepts.
- Explain networking and volume management.
- Help understand documentation.
- Review implementation decisions.

The final architecture, implementation, debugging, configuration and validation were performed by the project author.

---

## Architecture

Client
↓
NGINX (TLS)
↓
WordPress (PHP-FPM)
↓
MariaDB

---

## Project Structure

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs/
    ├── docker-compose.yml
    ├── .env
    ├── secrets/
    └── requirements/
        ├── mariadb/
        ├── nginx/
        └── wordpress/
```
