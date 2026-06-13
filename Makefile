
all: up

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

re: down up

.PHONY: all up down logs re
