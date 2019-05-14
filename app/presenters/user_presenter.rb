module Presenters
  module User
    def to_json
      {
        "login": login,
      }.to_json
    end
  end
end
