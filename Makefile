.DEFAULT_GOAL := help
PROJ_DIR := $(shell pwd)
SHELL = /bin/bash

# adjust this if the api is incremented

##@ General

help: ## List the make targets supported
	@echo "Here are the make targets for $(shell basename ${PROJ_DIR})."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Install - targets to install supporting software

install: install-mdl ## install all dependances

install-mdl: ## install markdown lint tool
	@echo "installing mdl using gem"
	gem install mdl

##@ Test - Quality Assurance targets to format, lint and test this repository

qa: qa-mdlint ## Run all qa targets for the repo

qa-mdlint: ## Run MArkdownlint on all files in repo
	@echo "Running markdownlint on repo"
	@mdl .

.PHONY: help install install-mdl qa qa-mdlint
