# frozen_string_literal: true

class HealthCheckController < ApplicationController
  def status
    "ok"
  end
end
