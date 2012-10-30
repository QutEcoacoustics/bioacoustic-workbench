require_relative  '../../lib/modules/qualified_const_get'

Given /^A (.*) user from the database$/ do |u|
  #
  @user  =   User.where(:display_name => u ).first!
  assert @user
end
When /^(.*) makes a change to the (.*) table$/ do |u, t|
  table_class = qualified_const_get("::" + t)
  @random_row = table_class.last!
  @random_row.save
end

When /^(.*) inserts a row in the (.*) table$/ do |u, t|
  table_class = qualified_const_get("::" + t)
  @random_row = table_class.new
  @random_row.save
end

Then /^Then the (.*) column should have (.*)'s id$/ do |c,u|
  puts (@random_row)
  puts (@random_row.to_yaml)
  @random_row.send(c) == @user.id
end