class CreateUsersService
  def self.perform(args={})
    new(args).perform
  end

  def initialize(args)
    @user_entity = args[:user_entity] || User
    @params = args[:params]
  end

  def perform
    instantiate_new_user
    set_user_information
    save_user

    return @user
  end

  private
  def instantiate_new_user
    @user = @user_entity.new
  end

  def set_user_information
    @user.login = @params[:login]
    @user.password = @params[:password]
  end

  def save_user
    @user.save!
  end
end
