# frozen_string_literal: true

class User < ActiveRecord::Base
  validate :encrypt_password, on: %i[create update]

  def encrypt_password
    self.password = BCrypt::Password.create(password)
  end
end
