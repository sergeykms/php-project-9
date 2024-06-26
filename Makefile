PORT ?= 8000
PORT_LOCAL ?= 8080
start:
	php -S 0.0.0.0:$(PORT) -t public public/index.php

loc:
	php -S localhost:$(PORT_LOCAL) -t public public/index.php

setup:
	composer install

compose:
	docker-compose up

compose-bash:
	docker-compose run web bash

compose-setup: compose-build
	docker-compose run web make setup

compose-build:
	docker-compose build

compose-down:
	docker-compose down -v


auto:
	composer dump-autoload

install: # install project
	composer install

validate: # validate composer.json
	composer validate

lint:
	composer exec --verbose phpcs -- --standard=PSR12 public templates
	composer exec --verbose phpstan

lint-fix:
	composer exec --verbose phpcbf -- --standard=PSR12 public templates