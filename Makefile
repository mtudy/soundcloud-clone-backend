include src/main/resources/application.properties
export

DOCKER_COMPOSE = cd docker && docker-compose -p soundcloud_clone_backend

.PHONY: flyway
flyway: ## run flyway, use 's' variable to select a service. make s=flywayInfo flyway
		./gradlew -Pflyway.url=$(spring.flyway.url) -Pflyway.schemas=$(spring.flyway.schemas) -Pflyway.user=$(spring.flyway.user) -Pflyway.password=$(spring.flyway.password) $(s)

.PHONY: start
start: erase build up ## clean current environment, recreate dependencies and spin up again

.PHONY: rebuild
rebuild: start ## same as start

.PHONY: erase
erase: ## stop and delete containers, clean volumes
		$(DOCKER_COMPOSE) stop
		$(DOCKER_COMPOSE) rm -v -f

.PHONY: build
build: ## build environment and initialize and project dependencies
		$(DOCKER_COMPOSE) build

.PHONY: up
up: ## spin up environment
		$(DOCKER_COMPOSE) up -d
