# README

This README would normally document whatever steps are necessary to get the
application up and running.

1. Configure file
Run: cp .env_example .env

2. Build project
- docker-compose build
- docker-compose up -d
- docker-compose up

3. Database migration
- docker-compose run --rm web bundle exec rake db:create
- docker-compose run --rm web bundle exec rake db:migrate

4. Rails console
- docker-compose run --rm web bundle exec rails console

* Debug in docker 
- docker attach vaccination_center_management_web_1



*docker-machine ip