require 'spec_helper'

# this class is required by devise.. we don't really use it, hence can't think of any good tests
describe Authorization do

  it {should belong_to(:user)}
end