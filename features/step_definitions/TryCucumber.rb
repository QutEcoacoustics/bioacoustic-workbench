Given /^I have entered input (\d+) into a sum$/ do |n|
  if @numbers.nil?
    @numbers = Array.new
  end
  @numbers.push n.to_i
end
When /^I evaluate the sum expression$/ do
  @result = 0
  @numbers.each do |number|
    @result += number
  end
end
Then /^the result should be (\d+)$/ do |result|
  @result == result
end