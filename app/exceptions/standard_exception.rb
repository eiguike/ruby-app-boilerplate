# frozen_string_literal: true

class StandardException < StandardError
  attr_reader :msg, :field

  def initialize(msg, field)
    @msg = msg
    @field = field
  end

  def to_json(opts = {})
    {
      "error": @msg,
      "field": @field
    }.to_json(opts)
  end
end
