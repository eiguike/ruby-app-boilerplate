require 'sinatra' 
require 'pry'
require 'active_record'

require './app/models/user'
require './app/controllers/application_controller'
require './app/controllers/user_controller'
require './app/controllers/health_check_controller'
require './config/routes'

ActiveRecord::Base.establish_connection(
  YAML.load_file("db/config.yml")[ENV["APP_ENV"]]
)

Routes.run!
