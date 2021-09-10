# Task manager

RESTful API to manage tasks.

Built with ruby on rails. 

It uses:
- [JSON Web Token (JWT)](https://jwt.io/) for authentication
- [sidekiq](https://github.com/mperham/sidekiq) to process notifications in the background
- [pundit](https://github.com/varvet/pundit) to manage authorizations

## To run the application locally:

`docker-compose up`

Runs on localhost port 3000.

If you're running this command for the first time, you'll need to create a database. In another terminal run: 

`docker-compose run web rails db:create db:migrate`

## To see the logs for the background processes, separately:

`docker-compose up sidekiq`

## To run the test suit locally:

`docker-compose -f docker-compose.tdd.yml run tdd rspec spec`

## API documentation:

[API Documentation WIKI](https://github.com/anansilva/task-manager-rails/wiki/API-Documentation)
