SHELL=/bin/bash

.PHONY: help build deploy run rm 

help: ## Show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <command> \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

build: ## Build the discinstock stack
	@echo "Build all images.."
	@cd ..; \
	cd discgolfspider && docker build -t discinstock_spider:stage -f docker/Dockerfile . && cd ..; \
	cd discinstock_api && docker build -t discinstock_api:stage -f docker/Dockerfile . && cd ..; \
	cd discinstock_app && docker build -t discinstock_app:stage --build-arg VUE_APP_API_URL=http://localhost:60001 . && cd ..;

deploy: ## Deploy the stack to swarm
	@echo "Deploying discinstock stack.."
	@docker stack deploy -c docker-compose.stage.yml discinstock

run: build deploy ## Build and deploy stack 
	
rm: ## Remove the stack
	@echo "Shutting down discinstock.."
	@docker stack rm discinstock