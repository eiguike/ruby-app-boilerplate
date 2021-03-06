# frozen_string_literal: true

class UserController < ApplicationController
  def show
    set_params do
      param login: { type: String }
    end

    user = User.find_by(login: params[:login])
    raise NotFoundException.new(:login) if user.nil?

    present(payload: user.extend(Presenters::User).to_json, status: 200)
  end

  def delete
    set_params do
      param login: { type: String }
    end

    user = User.find_by(login: params[:login])
    raise NotFoundException.new(:login) if user.nil?

    user.delete

    present(payload: { "result": "ok" }.to_json, status: 200)
  end

  def create
    set_params do
      param login: { type: String }
      param password: { type: String }
    end

    user = CreateUsersService.perform(user_entity: User, params: params)

    present(payload: user.extend(Presenters::User).to_json, status: 201)
  end

  def update
    set_params do
      param login: { type: String }
      param password: { type: String }
    end

    user = UpdateUsersService.perform(user_entity: User, params: params)

    present(payload: user.extend(Presenters::User).to_json, status: 200)
  end
end
