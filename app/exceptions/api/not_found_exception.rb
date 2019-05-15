# frozen_string_literal: true

require_relative "../standard_exception"

class NotFoundException < StandardException
  def initialize(field)
    msg = "#{field} not found"
    super(msg, field)
  end
end
