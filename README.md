docker-compose build
`docker-compose run -e RAILS_ENV=production rake db:drop db:create db:migrate db:seed`
docker-compose up
