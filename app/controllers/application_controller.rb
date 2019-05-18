# frozen_string_literal: true

class ApplicationController
  def initialize(routes)
    @routes = routes
    @params = parse_params
    @permitted_params = {}
    @missing_fields = []
  end

  def set_params
    yield
  end

  def present(options = {})
    @routes.status(options[:status] || 200)
    options[:payload]
  end

  def param(options = {})
    return (@permitted_params = options) if @permitted_params.nil?

    @permitted_params.merge!(options)
    @permitted_params
  end

  def params
    return @params if @permitted_params.empty?

    extract_parameters

    raise BadRequestException.new(@missing_fields) if @missing_fields.any?

    @returned_params
  end

  private

    def parse_params
      JSON.parse(@routes.request.body.read)
          .merge(@routes.params).with_indifferent_access
    rescue JSON::ParserError, TypeError
      @routes.params.with_indifferent_access
    end

    def extract_parameters
      @returned_params = @permitted_params.reduce({}) do |aux, key|
        if @params[key.first.to_s].nil?
          @missing_fields << key.first.to_s
          next aux
        end
        aux.merge(:"#{key.first}" => @params[key.first.to_s])
      end
    end
end
