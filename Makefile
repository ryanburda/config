.PHONY: build run
.DEFAULT_GOAL := help

build: ## Build the image
	@docker build -t container_env:dev .

run: ## Start the container if it isn't already started and then attach to that same container. OR create a new container if one does not already exist.
	@(docker container start container_env 2> /dev/null && docker container attach container_env) || \
	docker container run -it --name container_env --volume container_env_volume:/root container_env:dev

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
