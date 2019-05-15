# frozen_string_literal: true

class Routes < ApplicationRoutes
  get("/live") { HealthCheckController.new(self).status }

  post("/users") { UserController.new(self).create }
  get("/users/:login") { UserController.new(self).show }
  patch("/users/:login") { UserController.new(self).update }
  delete("/users/:login") { UserController.new(self).delete }
end
