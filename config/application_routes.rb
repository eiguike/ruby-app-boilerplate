class ApplicationRoutes < Sinatra::Base
  set :bind, "0.0.0.0"
  set :show_exceptions, false

  before do
    content_type "application/json"
  end

  error do |err|
    raise err
  rescue ActiveRecord::RecordNotUnique
    status 409
    return {
      "msg": "Already exists this resource",
    }.to_json
  rescue NotFoundException => exception
    status 404
    exception.to_json
  rescue BadRequestException => exception
    status 400
    exception.to_json
  end
end
