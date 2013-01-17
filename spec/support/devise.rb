RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

=begin
class ActionController::TestCase
  include Devise::TestHelpers

  @current_logged_in_user

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_logged_in_user = get_admin
    sign_in @current_logged_in_user
    @current_logged_in_user.reset_authentication_token!
  end

  def get_admin
    User.where(:user_name => 'admin').first!
  end

  def get_user(user_name)
    User.where(:user_name => user_name).first!
  end

end
=end

# # user for tests - user name is from development_seeds.rb
#@user = User.where(:display_name => 'A normal user').first!