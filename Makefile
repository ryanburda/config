.PHONY: build run

build: ## Build the image
	docker build -t container_env:dev .

run: ## Start the environment
	(docker container start container_env && docker container attach container_env) || docker container run -it --name container_env --volume container_env_volume:/root container_env:dev
