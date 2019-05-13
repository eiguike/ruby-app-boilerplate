module Presenters
  module User
    def to_json
      {
        "login": self.login
      }.to_json
    end
  end
end
