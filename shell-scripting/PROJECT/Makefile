.ONESHELL:
.SHELL := /usr/bin/bash
.PHONY: All Robo-Shop

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[35m%-10s\033[0m %s\n", $$1, $$2}'


all: ##Install ROBO-Shop Application.
	@sh ROBO-Shop.sh


mongodb: ##Install mongodb 
	@sh ROBO-Shop.sh mongodb


rabbitmq: ##Install rabbitmq
	@sh ROBO-Shop.sh rabbitmq
