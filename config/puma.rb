# frozen_string_literal: true

workers Integer(ENV["WEB_CONCURRENCY"] || 2)
threads_count = Integer(ENV["APP_MAX_THREADS"] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV["PORT"]     || 3000
environment ENV["APP_ENV"] || "development"

on_worker_boot do
  ActiveRecord::Base.establish_connection(
    YAML.safe_load(ERB.new(File.new("db/config.yml").read)
    .result(binding), aliases: true)[ENV["APP_ENV"]]
  )
end
