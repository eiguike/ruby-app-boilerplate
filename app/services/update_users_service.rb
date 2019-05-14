class UpdateUsersService
  def self.perform(args = {})
    new(args).perform
  end

  def initialize(args)
    @user_entity = args[:user_entity] || User
    @params = args[:params]
  end

  def perform
    find_user
    set_user_information
    update_user

    @user
  end

  private

  def find_user
    @user = @user_entity.find_by(login: @params[:login])
    raise NotFoundException.new(:login) if @user.nil?
  end

  def set_user_information
    @user.password = @params[:password]
  end

  def update_user
    @user.save!
  end
end
