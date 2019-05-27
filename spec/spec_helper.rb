require "active_record"
require "active_support"
require "bcrypt"
require "erb"
require "factory_bot"
require "faker"
require "pry"
require "rack/test"
require "require_all"
require "sinatra"

require_all "./app"
require_relative "../config/application_routes"
require_relative "../config/routes"

ActiveRecord::Base.establish_connection(
  YAML.safe_load(ERB.new(File.new("db/config.yml").read)
    .result(binding), aliases: true)[ENV["APP_ENV"]]
)

Lib::Logger.configure do |logger|
  logger.set_information :host => "TESTING_HOST"
  logger.set_information :environment => ENV["APP_ENV"]
  logger.set_information :application => "ruby-app"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

def app
  Routes.new
end
