.PHONY: build run

build: ## Build the image
	docker build -t container_env .

run: build ## Start the environment
	docker run -it container_env
