# frozen_string_literal: true

require "sinatra"
require "pry"
require "active_record"
require "active_support"
require "require_all"
require "bcrypt"
require "erb"

require_all "./app"
require_relative "./config/application_routes"
require_relative "./config/routes"

Routes.run!
