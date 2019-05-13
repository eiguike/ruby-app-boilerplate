class ApplicationRoutes < Sinatra::Base
  before do
    content_type 'application/json'
  end

  error do |err|
    begin
      raise err
    rescue ActiveRecord::RecordNotUnique => exception
      status 202
      return {
        "msg": "Already exists this resource"
      }.to_json
    rescue BadRequestException => exception
      status 400
      exception.to_json
    end
  end
end
