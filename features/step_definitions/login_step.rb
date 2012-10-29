Given /^a user is logged in as "(.*)"$/ do |login|
  # https://github.com/cucumber/cucumber/wiki/Ruby-on-Rails
  @current_user = User.create!(
      :login => login,
      :password => 'generic',
      :password_confirmation => 'generic',
      :email => "#{login}@example.com"
  )

  # :create syntax for restful_authentication w/ aasm. Tweak as needed.
  # @current_user.activate! 

  visit "/login"
  fill_in("login", :with => login)
  fill_in("password", :with => 'generic')
  click_button("Log in")
  response.body.should =~ /Logged/m
end