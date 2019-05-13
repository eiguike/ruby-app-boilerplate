require 'sinatra' 
require 'pry'
require 'active_record'
require 'require_all'
require 'bcrypt'

require_all './app'
require_all './config'

ActiveRecord::Base.establish_connection(
  YAML.load_file("db/config.yml")[ENV["APP_ENV"]]
)

Routes.run!
