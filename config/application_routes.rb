# frozen_string_literal: true

class ApplicationRoutes < Sinatra::Base
  set :bind, "0.0.0.0"
  set :show_exceptions, false
  set :raise_errors, false

  before do
    content_type "application/json"
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
