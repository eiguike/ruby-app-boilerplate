require "require_all"
require "sinatra"
require "pry"
require "active_record"
require "rack/test"

require_all "./app"
require_all "./config"

ActiveRecord::Base.establish_connection(
  YAML.load(ERB.new(File.new("db/config.yml").read).result(binding))["test"]
)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def app
  Routes.new
end
