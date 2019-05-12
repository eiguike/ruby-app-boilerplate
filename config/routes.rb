class Routes < Sinatra::Base
  get '/live' do
    HealthCheckController.new(self).status
  end

  post '/users' do
    UserController.new(self).create
  end
end
