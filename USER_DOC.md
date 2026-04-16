# User Documentation

## 1. Starting the Application

Run:

```bash
make
```

---

## 2. Access

Open in browser:

```
https://isegura.42.fr
```

---

## 3. Stopping the Application

```bash
make down
```

---

## 4. Clean Restart

```bash
make fclean
make
```

---

## 5. Data Persistence

All data is stored in:

```
/home/isegura/data/
```

Data remains intact after container rebuilds unless manually deleted.

---

## 6. Troubleshooting

### WordPress cannot connect to database

Check container status:

```bash
sudo docker ps
```

Check logs:

```bash
sudo docker logs mariadb
sudo docker logs wordpress
```

---

### HTTPS warning in browser

Expected behavior due to self-signed certificate.

---

## 7. Useful Commands

```bash
sudo docker ps
sudo docker logs <container>
```

---

