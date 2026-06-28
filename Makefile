
up:
	mkdir -p ~/data/mariadb ~/data/webdata;
	docker compose -f srcs/docker-compose.yml up -d --build;
	docker compose -f srcs/docker-compose.yml ps;

stop:
	docker compose -f srcs/docker-compose.yml stop

restart:
	docker compose -f srcs/docker-compose.yml restart

down: stop
	docker compose -f srcs/docker-compose.yml down

logs:
	docker logs srcs-nginx-1;
	docker logs srcs-php-fpm-1;
	docker logs srcs-mariadb-1;

clean: down	
	docker image prune -af

volclean:
	docker volume rm $$(docker volume ls -q);
	sudo rm -rf ~/data/mariadb ~/data/webdata;

fclean: clean volclean
	docker system prune -af

re: down up

.PHONY: up stop restart down logs clean fclean volclean re
