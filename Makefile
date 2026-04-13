NAME = inception
COMPOSE = sudo docker compose -f srcs/docker-compose.yml

all: seg

up:
	$(COMPOSE) up --build

seg:
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

re: down up

clean:
	$(COMPOSE) down -v --rmi all

fclean: clean
	sudo docker system prune -af

ps:
	sudo docker ps

logs:
	$(COMPOSE) logs

mariadb:
	sudo docker exec -it mariadb bash

wordpress:
	sudo docker exec -it wordpress bash

nginx:
	sudo docker exec -it nginx bash

.PHONY: all up down re clean fclean ps logs mariadb wordpress nginx
