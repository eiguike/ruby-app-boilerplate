require "logger"

module Lib
  class Logger
    class << self
      attr_accessor :information
      attr_accessor :logger_object

      private
      def apply_formatter
        self.logger_object.formatter = proc do |severity, datetime, application, message|
          {
            timestamp: datetime,
            severity: severity,
            message: message
          }.merge(information).to_json + "\n"
        end
      end
    end

    def self.configure
      self.logger_object = ::Logger.new("/dev/null") if ENV["APP_ENV"] == "test"
      self.logger_object = ::Logger.new(STDOUT) if ["development", "production"].include? ENV["APP_ENV"]
      apply_formatter if ENV["APP_ENV"] == "production"
      yield self
    end

    def self.set_information(options = {})
      self.information = {} if self.information.nil?
      self.information.merge!(options)
    end
  end
end
