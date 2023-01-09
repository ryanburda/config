.PHONY: build run

build: ## Build the image
	docker build -t container_env .

run: ## Start the environment
	docker container run -it --name container_env --volume container_env_volume:/root container_env

attach:
	docker container attach container_env

start:
	docker container start container_env
