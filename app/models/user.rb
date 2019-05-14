class User < ActiveRecord::Base
  validate :encrypt_password, on: [:create, :update]

  def encrypt_password
    self.password = BCrypt::Password.create(password)
  end
end
