COMPOSE = cd ./srcs/ && docker compose
MARIADB_DATA="/home/naalzaab/data/mariadb_data"
WP_FILES="/home/naalzaab/data/wp_files"

up: key-generate
	mkdir -p $(MARIADB_DATA) $(WP_FILES) && \
	$(COMPOSE) -f docker-compose.yml up --build -d

down:
	$(COMPOSE) -f docker-compose.yml down
	@rm -rf ./secrets

re: down up

fclean: down
	@yes | docker system prune --all
	@docker volume rm $$(docker volume ls -q)
# docker stop $(docker ps -aq); docker rm $(docker ps -qa); docker rmi $(docker images -aq); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

nginx-down:
	$(COMPOSE) -f docker-compose.yml stop nginx
	$(COMPOSE) -f docker-compose.yml rm -f nginx

nginx-up:
	$(COMPOSE) -f docker-compose.yml up --build -d nginx

nginx-rebuild: nginx-down nginx-up

rebuild: fclean up

# self signed certificate generating
key-generate:
	mkdir -p ./secrets && \
	cd ./srcs/requirements/nginx/tools && chmod 755 generate_certs.sh && ./generate_certs.sh && cd -
