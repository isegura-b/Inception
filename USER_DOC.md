# User Documentation

## Purpose

This document explains how to use and manage the Inception infrastructure.

---

## Starting the Application

Build and start all services:

```bash
make
```

Verify containers:

```bash
docker ps
```

Expected services:

- nginx
- wordpress
- mariadb

---

## Accessing the Website

Open:

```text
https://isegura.42.fr
```

Because a self-signed TLS certificate is used, the browser may display a security warning.

Accept the warning and continue.

---

## Accessing the WordPress Admin Panel

Open:

```text
https://isegura.42.fr/wp-admin
```

Login using the administrator credentials configured during installation.

---

## Managing Credentials

Passwords are stored as Docker secrets:

```text
srcs/secrets/
```

Files:

```text
db_password.txt
db_root_password.txt
wp_admin_password.txt
wp_user_password.txt
```

If credentials are modified, rebuild the infrastructure:

```bash
make re
```

---

## Basic Checks

Verify running containers:

```bash
docker ps
```

Check logs:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

Check volumes:

```bash
docker volume ls
```

---

## Stopping Services

```bash
make down
```

---

## Full Cleanup

```bash
make fclean
```

This removes containers, images, networks and generated resources.
