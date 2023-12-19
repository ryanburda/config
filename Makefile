.PHONY: build run
.DEFAULT_GOAL := help

build:
	@docker build -t tmux-server .

start:
	@docker compose up --force-recreate --detach

stop:
	@docker compose down

dev:
	@docker exec -it config-tmux-server-1 tmux new-session

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
