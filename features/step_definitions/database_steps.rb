require_relative  '../../lib/modules/qualified_const_get'

Given /^A (.*) user from the database$/ do |u|
  # need to somehow "login"
  @user  =   User.where(:display_name => u ).first!
  assert @user
end
When /^(.*) makes a change to the (.*) table$/ do |u, t|
  @table_class = qualified_const_get("::" + t)
  @random_row = @table_class.last!
  @original =  Marshal::load(Marshal.dump(@random_row))
  @random_row.save
end

When /^(.*) inserts a row in the (.*) table$/ do |u, t|
  @table_class = qualified_const_get("::" + t)
  @random_row = @table_class.new
  @original =  Marshal::load(Marshal.dump(@random_row))
  @random_row.save
end

Then /^the (.*) column should have (.*)'s id$/ do |c,u|
  #puts (@random_row)
  #puts (@random_row.to_yaml)
  @random_row.send(c) == @user.id
end
When /^the (.*) column should have changed$/ do |c|
  assert @random_row.send(c) != @original.send(c)
end
When /^the (.*) column should approximately equal the current time$/ do |c|
  assert (DateTime.current - @random_row.send(c)) < 2.seconds
end
When /^(.*) deletes a row from the (.*) table$/ do |u, t|
  @table_class = qualified_const_get("::" + t)
  @random_row = @table_class.last!
  @original =  Marshal::load(Marshal.dump(@random_row))
  @random_row.destroy
end
When /^(.*) deletes that row again from the table$/ do |u|
  @random_row.destroy!
end
Then /^the record should no longer exist$/ do
  assert @table_class.with_deleted.where(:id => @orginal.id).first.nil?

end