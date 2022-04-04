.DEFAULT_GOAL := help
PROJ_DIR := $(shell pwd)
SHELL = /bin/bash

# adjust this if the api is incremented

##@ General

help: ## List the make targets supported
	@echo "Here are the make targets for $(shell basename ${PROJ_DIR})."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Install - targets to install supporting software

install: install-mdl ## install all dependencies

install-docker: ## install markdown lint tool
	# TODO need to get a standard install tool for docker
	@echo "docker is needed"

##@ Test - Quality Assurance targets to format, lint and test this repository

qa: qa-lint  ## Run all QA targets on repository

qa-lint:  ## lint all code type in the repo
	@docker run --rm -v /Users/doug/github/dschveninger.github.io:/tmp/lint megalinter/megalinter:v5

lint-arg:  ## run linter against all files. make lint-arg REGEX={file or directory}
	@docker run --rm -e FILTER_REGEX_INCLUDE=$(REGEX) -v /Users/doug/github/dschveninger.github.io:/tmp/lint megalinter/megalinter:v5

lint-run:  ## run all linter against all files
	@docker run --rm -ti --entrypoint=/bin/bash -v /Users/doug/github/dschveninger.github.io:/tmp/lint megalinter/megalinter:v5

.PHONY: help install install-docker qa qa-lint
