NAME=transcendence
DOCKER_COMPOSE = docker compose --project-name ${NAME}

GREEN := \033[32m
RESET := \033[0m

all: create-volumes
	${DOCKER_COMPOSE} up -d

create-volumes:
	@printf "Checking and creating volume directories if necessary...\n"
	./scripts/create_volumes.sh
	@printf "${GREEN}Volume directories created successfully.${RESET}\n"

clean:
	@printf "Stopping and removing containers...\n"
	${DOCKER_COMPOSE} down

fclean: clean
	@printf "Removing images and networks, but keeping volumes...\n"
	docker run -v $HOME:/mnt alpine rm -rf /mnt/transcendence
	docker network rm $$(docker network ls -q --filter name=${NAME}) || true
	docker image rm $$(docker images -q --filter reference="${NAME}_*") || true

clean-volumes:
	@printf "Removing Docker volumes and associated directories...\n"
	@docker volume rm $$(docker volume ls -q --filter name=${NAME}) || true
	./scripts/clean_volumes.sh
	@printf "${GREEN}Volumes removed successfully.${RESET}\n"

re: clean all

init:
	@printf "Creating .env file...\n"
	./scripts/create_env.sh
	@printf "${GREEN}File .env initialized successfully.${RESET}\n"

help:
	@printf "\n"
	@printf "init:\n"
	@printf "    Creates .env file.\n"
	@printf "\n"
	@printf "all:\n"
	@printf "    Builds the project, creates volumes, and starts containers.\n"
	@printf "\n"
	@printf "create-volumes:\n"
	@printf "    Checks and creates volume directories if they don't exist.\n"
	@printf "\n"
	@printf "clean:\n"
	@printf "    Stops and removes containers.\n"
	@printf "\n"
	@printf "fclean:\n"
	@printf "    Stops containers, removes images and networks, but keeps volumes.\n"
	@printf "\n"
	@printf "clean-volumes:\n"
	@printf "    Removes Docker volumes and associated directories. DO NOT USE WITHOUT PERMISSION.\n"
	@printf "\n"
	@printf "re:\n"
	@printf "    Cleans and rebuilds the project.\n"
	@printf "\n"

.PHONY: all create-volumes clean fclean clean-volumes re init help
