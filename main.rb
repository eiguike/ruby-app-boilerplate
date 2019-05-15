# frozen_string_literal: true

require "sinatra"
require "pry"
require "active_record"
require "active_support"
require "require_all"
require "bcrypt"
require "erb"

require_all "./app"
require_all "./config"

ActiveRecord::Base.establish_connection(
  YAML.safe_load(ERB.new(File.new("db/config.yml").read)
    .result(binding), aliases: true)[ENV["APP_ENV"]]
)

Routes.run!
