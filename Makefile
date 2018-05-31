test:
	docker-compose run --rm processing python -m unittest discover
	docker-compose run --rm processing bash -c "cd data_collection && scrapy check"

setup:
	cp .env.example .env
	docker-compose pull
	docker-compose build
	make seed

seed:
	docker-compose up --detach postgres
	docker-compose run --rm processing python3 -c "import database; database.initialize()"
