class ApplicationController
  attr_reader :params

  def initialize(routes)
    @routes = routes
    @params = (JSON.parse(routes.request.body.read) rescue {})
  end
end
