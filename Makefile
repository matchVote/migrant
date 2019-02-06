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
	docker-compose run --rm migrant mix ecto.setup
	docker-compose run --rm -e MIX_ENV=test migrant mix ecto.setup