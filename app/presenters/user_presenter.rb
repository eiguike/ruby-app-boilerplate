# frozen_string_literal: true

module Presenters
  module User
    def to_json(opts = {})
      {
        "login": login
      }.to_json(opts)
    end
  end
end
