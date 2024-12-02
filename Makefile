NAME=docker-files
DOCKER_COMPOSE = docker compose --project-name ${NAME}
VOLUME= postgresql media prometheus grafana
VOLUME_DIR = ${HOME}/${NAME}

# all: env create-volumes
# 	${DOCKER_COMPOSE} up --build -d

all: create-volumes
	${DOCKER_COMPOSE} up -d

# env:
# 	./scripts/create_env.sh

create-volumes:
	@echo "Checking and creating volume directories if necessary..."
	@for volume in ${VOLUMES}; do \
		if [ ! -d "${VOLUME_DIR}/$$volume" ]; then \
			echo "Creating directory: ${VOLUME_DIR}/$$volume"; \
			mkdir -p "${VOLUME_DIR}/$$volume"; \
		else \
			echo "Directory already exists: ${VOLUME_DIR}/$$volume"; \
		fi \
	done

clean:
	@echo "Stopping and removing containers..."
	${DOCKER_COMPOSE} down

fclean: clean
	@echo "Removing images and networks, but keeping volumes..."
	docker network rm $$(docker network ls -q --filter name=${NAME}) || true
	docker image rm $$(docker images -q --filter reference="${NAME}_*") || true

clean-volumes:
	@echo "Removing Docker volumes and associated directories..."
	@docker volume rm $$(docker volume ls -q --filter name=${NAME}) || true
	@for volume in ${VOLUMES}; do \
		if [ -d "${VOLUME_DIR}/$$volume" ]; then \
			echo "Removing directory: ${VOLUME_DIR}/$$volume"; \
			rm -rf "${VOLUME_DIR}/$$volume"; \
		else \
			echo "Directory does not exist: ${VOLUME_DIR}/$$volume"; \
		fi \
	done

submodule-back:
	@echo "Resetting Data submodule..."
	@bash scripts/submodule_back.sh

submodule-front:
	@echo "Checking if the front_transcendence submodule exists..."
	@if [ -d "Frontend/front_transcendence/.git" ]; then \
		echo "Submodule exists. Updating..."; \
		cd Frontend/front_transcendence && git pull origin main && cd ../..; \
	else \
		echo "Submodule does not exist. Adding..."; \
		cd Frontend && \
		git submodule add git@github.com:LaTeam-Trancendence/front_transcendence.git && cd ..; \
	fi
	@echo "Process completed successfully!"


submodules: submodule-back submodule-front

re: clean all

help:
	@echo ""
	@echo "all:"
	@echo "    Builds the project, creates volumes, and starts containers."
	@echo ""
	@echo "create-volumes:"
	@echo "    Checks and creates volume directories if they don't exist."
	@echo ""
	@echo "clean:"
	@echo "    Stops and removes containers."
	@echo ""
	@echo "fclean:"
	@echo "    Stops containers, removes images and networks, but keeps volumes."
	@echo ""
	@echo "clean-volumes:"
	@echo "    Removes Docker volumes and associated directories. DO NOT USE WITHOUT PERMISSION."
	@echo ""
	@echo "submodule-back:"
	@echo "    Adds or updates the back submodule."
	@echo ""
	@echo "submodule-front:"
	@echo "    Adds or updates the front submodule."
	@echo ""
	@echo "submodules:"
	@echo "    Runs both submodule-back and submodule-front tasks."
	@echo ""
	@echo "re:"
	@echo "    Cleans and rebuilds the project."
	@echo ""

.PHONY: all create-volumes clean fclean clean-volumes submodule-back \
	submodule-front submodules help re