# frozen_string_literal: true

require_relative "../app/helpers/logger_helper"

class ApplicationRoutes < Sinatra::Base
  include Helpers::LoggerHelper

  configure do
    set :bind, "0.0.0.0"
    set :show_exceptions, false
    set :raise_errors, false
    set :server, :puma
  end

  before do
    logger.info "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']} Started"
    content_type "application/json"
  end

  after do
    logger.info "#{env['REQUEST_METHOD']} #{env['REQUEST_PATH']} Finished"
  end

  error do |err|
    raise err
  rescue ActiveRecord::RecordNotUnique
    status 409
    return {
      "msg": "Already exists this resource"
    }.to_json
  rescue NotFoundException => e
    status 404
    e.to_json
  rescue BadRequestException => e
    status 400
    e.to_json
  end
end
