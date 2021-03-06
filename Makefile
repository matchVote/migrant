.PHONY: help

APP_NAME ?= `grep 'app:' mix.exs | sed -e 's/\[//g' -e 's/ //g' -e 's/app://' -e 's/[:,]//g'`
APP_VSN ?= `grep 'version:' mix.exs | cut -d '"' -f2`

help:
	@echo $(APP_NAME):$(APP_VSN)
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

version: ## Show latest app version
	@echo $(APP_VSN)

build: ## Build the Docker image
	docker build --build-arg APP_NAME=$(APP_NAME) \
	--build-arg APP_VSN=$(APP_VSN) \
	-t $(APP_NAME):$(APP_VSN) .

start: ## Start DB as daemon
	docker-compose up -d --scale migrant=0

setup: ## Initial setup of DB for dev/test
	docker-compose build
	docker-compose run --rm migrant mix ecto.setup
	docker-compose run --rm -e MIX_ENV=test migrant mix ecto.setup

reset: ## Redo the initial setup of DB for dev/test
	docker-compose run --rm migrant mix ecto.reset
	docker-compose run --rm -e MIX_ENV=test migrant mix ecto.reset

migrate: ## Migrate DB for dev/test
	docker-compose run --rm migrant mix ecto.migrate
	docker-compose run --rm -e MIX_ENV=test migrant mix ecto.migrate

rollback: ## Rollback previous migration for dev/test
	docker-compose run --rm migrant mix ecto.rollback
	docker-compose run --rm -e MIX_ENV=test migrant mix ecto.rollback

mixtest: ## Test in context of containers
	docker-compose run --rm -e MIX_ENV=test migrant mix test

heroku-push: ## Use Heroku to build production image and push to registry
	heroku container:login
	heroku container:push worker \
	  --verbose \
	  --arg APP_NAME=$(APP_NAME),APP_VSN=$(APP_VSN),MIX_ENV=prod \
	  --app mv-migrant

heroku-release: ## Deploy container from previously pushed image
	heroku container:release worker --app mv-migrant
