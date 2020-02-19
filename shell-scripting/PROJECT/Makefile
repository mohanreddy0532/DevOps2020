ONESHELL:
.SHELL := /usr/bin/bash
.PHONY: all mongodb

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[35m%-10s\033[0m %s\n", $$1, $$2}'

pull:
	@git pull &>/dev/null

all: pull ## Install all Components of Application
	@sh PROJECT.sh all

debug:
	@sh -x PROJECT.sh all
