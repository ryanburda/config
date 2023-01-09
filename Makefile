.PHONY: build run

build: ## Build the image
	docker build -t container_env .

run: build ## Start the environment
	docker container start container_env --attach || docker container run -it --name container_env --volume container_env_volume:/ container_env
