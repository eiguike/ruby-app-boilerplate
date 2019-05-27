# frozen_string_literal: true

module Helpers
  module LoggerHelper
    def logger
      Lib::Logger.logger_object
    end
  end
end
