class UserController < ApplicationController
  def create
    set_params do |options|
      param login: { type: String }
      param password: { type: String }
    end

    user = CreateUsersService.perform(user_entity: User, params: params)

    present(payload: user.extend(Presenters::User).to_json, status: 201)
  end
end
