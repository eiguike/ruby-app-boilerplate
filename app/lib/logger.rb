# frozen_string_literal: true

require "logger"

module Lib
  class Logger
    APPLIED_LOGGER = %w[development production].freeze

    class << self
      attr_accessor :information
      attr_accessor :logger_object
      attr_accessor :request_id

      private

        def apply_formatter
          logger_object.formatter =
            proc do |severity, datetime, _application, message|
              {
                timestamp: datetime,
                severity: severity,
                message: message
              }.merge(with_request_id)
                .merge(Logger.information).to_json + "\n"
            end
        end

        def initalize_logger(output)
          self.logger_object = ::Logger.new(output)
        end

        def with_request_id
          return {} if Logger.request_id.nil?

          Logger.request_id.call
        end
    end

    def self.configure
      initalize_logger("/dev/null") if ENV["APP_ENV"] == "test"
      initalize_logger(STDOUT) if APPLIED_LOGGER.include? ENV["APP_ENV"]
      apply_formatter if ENV["APP_ENV"] == "production"
      yield self
    end

    def self.add_request_id(callback)
      Logger.request_id = callback
    end

    def self.add_information(options = {})
      Logger.information = {} if Logger.information.nil?
      Logger.information.merge!(options)
    end
  end
end
