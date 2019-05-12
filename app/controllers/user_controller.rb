class UserController < ApplicationController
  def create
    set_params do |options|
      param login: { type: String }
      param password: { type: String }
    end

    CreateUsersService.perform(user_entity: User, params: params)
  end
end
