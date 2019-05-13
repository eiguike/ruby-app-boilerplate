class ApplicationController
  attr_reader :params

  def initialize(routes)
    @routes = routes
    @params = (JSON.parse(routes.request.body.read) rescue {})
    @permitted_params = {}
  end

  def set_params
    yield
  end

  def present(options = {})
    @routes.status(options[:status] || 200)
    return options[:payload]
  end

  def param(options={})
    (return (@permitted_params = options)) if @permitted_params.nil?
    @permitted_params.merge!(options)
    @permitted_params
  end

  def params
    return @params if @permitted_params.empty?
    missing_fields = []
    returned_params = @permitted_params.reduce({}) do |aux, key|
      if @params[key.first.to_s].nil?
        missing_fields << key.first.to_s
        next aux
      end
      aux.merge("#{key.first}": @params[key.first.to_s])
    end

    raise BadRequestException.new(missing_fields) if missing_fields.any?
    returned_params
  end

end
