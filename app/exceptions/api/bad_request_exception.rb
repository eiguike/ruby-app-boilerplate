# frozen_string_literal: true

require_relative "../standard_exception"

class BadRequestException < StandardException
  def initialize(field)
    @msg = "The following fields (#{field.join(', ')}) are missing!"
    @field = field
    super(@msg, @field)
  end
end
