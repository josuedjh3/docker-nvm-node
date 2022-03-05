.PHONY: build
build:
	docker build \
	--target base \
	--tag josuedjhcayola/docker-nvm-node:lastest \
	.

.PHONY: frontend
frontend:
	docker-compose run --rm --service-ports --use-aliases frontend bash