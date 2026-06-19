
all: up

up:
	docker compose -f srcs/docker-compose.yml up -d --build

stop:
	docker compose -f srcs/docker-compose.yml stop

restart:
	docker compose -f srcs/docker-compose.yml restart

down: stop
	docker compose -f srcs/docker-compose.yml down

logs:
	docker compose logs -f srcs/docker-compose.yml

clean: down	
	docker image prune -af; \

fclean: clean
	docker system prune -af --volumes

re: down up

.PHONY: all up stop restart down logs clean fclean re
