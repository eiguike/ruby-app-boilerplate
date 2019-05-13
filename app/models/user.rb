class User < ActiveRecord::Base
  validate :encrypt_password, on: [:create, :update]

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end
end
