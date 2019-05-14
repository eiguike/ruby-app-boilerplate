require "sinatra"
require "pry"
require "active_record"
require "require_all"
require "bcrypt"
require "erb"

require_all "./app"
require_all "./config"

ActiveRecord::Base.establish_connection(
  YAML.load(ERB.new(File.new("db/config.yml").read).result(binding))[ENV["APP_ENV"]]
)

Routes.run!
