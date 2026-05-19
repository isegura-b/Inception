NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

all: secrets seg

secrets:
	mkdir -p srcs/secrets
	@if [ ! -f srcs/secrets/db_password.txt ]; then echo "db_password" > srcs/secrets/db_password.txt; fi
	@if [ ! -f srcs/secrets/db_root_password.txt ]; then echo "db_root_password" > srcs/secrets/db_root_password.txt; fi
	@if [ ! -f srcs/secrets/wp_admin_password.txt ]; then echo "wp_admin_password" > srcs/secrets/wp_admin_password.txt; fi
	@if [ ! -f srcs/secrets/wp_user_password.txt ]; then echo "wp_user_password" > srcs/secrets/wp_user_password.txt; fi

up: secrets
	$(COMPOSE) up --build

seg: secrets
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

re: down seg

clean:
	$(COMPOSE) down -v --rmi all

fclean: clean
	rm -rf srcs/secrets
	docker system prune -af

ps:
	docker ps

logs:
	$(COMPOSE) logs

mariadb:
	docker exec -it mariadb bash

wordpress:
	docker exec -it wordpress bash

nginx:
	docker exec -it nginx bash

.PHONY: all secrets up seg down re clean fclean ps logs mariadb wordpress nginx
