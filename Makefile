
IMAGENAME="bitnoize/node-workspace"

.PHONY: help build push shell

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build push shell"

build: .build-node-18 .build-node-16

.build-node-18:
	docker build --pull --no-cache \
		--build-arg NODE_VERSION=18-bullseye \
		-t "$(IMAGENAME):node-18" \
		-t "$(IMAGENAME):latest" \
		.

.build-node-16:
	docker build --pull --no-cache \
		--build-arg NODE_VERSION=16-bullseye \
		-t "$(IMAGENAME):node-16" \
		.

push: .push-node-18 .push-node-16

.push-node-18:
	docker push "$(IMAGENAME):node-18"
	docker push "$(IMAGENAME):latest"

.push-node-16:
	docker push "$(IMAGENAME):node-16"

shell:
	docker run -it --rm \
		--name node-workspace-shell \
		bitnoize/node-workspace:latest

