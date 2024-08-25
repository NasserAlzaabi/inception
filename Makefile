COMPOSE = cd ./srcs/ && docker compose


up: key-generate
	$(COMPOSE) -f docker-compose.yml up --build -d

down:
	$(COMPOSE) -f docker-compose.yml down
	@rm -rf ./secrets

fclean: down
	@yes | docker system prune --all
	@docker volume rm $$(docker volume ls -q)

nginx-down:
	$(COMPOSE) -f docker-compose.yml stop nginx
	$(COMPOSE) -f docker-compose.yml rm -f nginx

nginx-up:
	$(COMPOSE) -f docker-compose.yml up --build -d nginx

nginx-rebuild: nginx-down nginx-up

rebuild: fclean up

re: down up

# self signed certificate generating
key-generate:
	mkdir -p ./secrets && \
	cd ./srcs/requirements/nginx/tools && chmod 755 generate_certs.sh && ./generate_certs.sh && cd -
