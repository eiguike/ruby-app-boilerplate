class StandardException < StandardError
  def initialize(msg, field)
    @msg = msg
    @field = field
  end

  def to_json
    {
      "error": @msg,
      "field": @field,
    }.to_json
  end
end
