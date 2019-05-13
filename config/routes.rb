class Routes < ApplicationRoutes
  get '/live' do
    HealthCheckController.new(self).status
  end

  post '/users' do UserController.new(self).create end
  get '/users/:login' do UserController.new(self).show end
  patch '/users/:login' do UserController.new(self).update end
  delete '/users/:login' do UserController.new(self).delete end
end
