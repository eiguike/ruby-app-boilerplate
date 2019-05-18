# frozen_string_literal: true

class HealthCheckController < ApplicationController
  def status
    { "result": "ok" }.to_json
  end
end
