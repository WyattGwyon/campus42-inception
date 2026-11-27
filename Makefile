
up:
	mkdir -p ~/data ~/data/mariadb ~/data/webdata ~/data/kumadata;
	docker compose -f srcs/docker-compose.yml up -d --build;
	docker compose -f srcs/docker-compose.yml ps;

stop:
	docker compose -f srcs/docker-compose.yml stop

restart:
	docker compose -f srcs/docker-compose.yml restart

down: stop
	docker compose -f srcs/docker-compose.yml down

logs:
	@echo ""
	@echo "[NGINX]"
	docker logs srcs-nginx-1;
	@echo ""
	@echo "[WORDPRESS]"
	docker logs srcs-php-fpm-1;
	@echo ""
	@echo "[MARIADB]"
	docker logs srcs-mariadb-1;

clean: down	
	docker image prune -af

volclean:
#	docker volume rm $$(docker volume ls -q);
	docker volume rm srcs_webdata srcs_dbdata;
	sudo rm -rf ~/data;

fclean: clean volclean
	docker system prune -af

re: down up

.PHONY: up stop restart down logs clean fclean volclean re
