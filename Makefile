
IMAGENAME="bitnoize/node-workspace"

.PHONY: help build push pull shell

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build push pull shell"

build: .build-18-bullseye .build-16-bullseye

.build-18-bullseye:
	docker build --pull --no-cache \
		--build-arg NODE_VERSION=18-bullseye \
		-t "$(IMAGENAME):18-bullseye" \
		-t "$(IMAGENAME):latest" \
		.

.build-16-bullseye:
	docker build --pull --no-cache \
		--build-arg NODE_VERSION=16-bullseye \
		-t "$(IMAGENAME):16-bullseye" \
		.

push: .push-18-bullseye .push-16-bullseye

.push-18-bullseye:
	docker push "$(IMAGENAME):18-bullseye"
	docker push "$(IMAGENAME):latest"

.push-16-bullseye:
	docker push "$(IMAGENAME):16-bullseye"

pull: .pull-18-bullseye .pull-16-bullseye

.pull-18-bullseye:
	docker pull "$(IMAGENAME):18-bullseye"
	docker pull "$(IMAGENAME):latest"

.pull-16-bullseye:
	docker pull "$(IMAGENAME):16-bullseye"

shell:
	docker run -it --rm \
		--name node-workspace-shell \
		bitnoize/node-workspace:latest

