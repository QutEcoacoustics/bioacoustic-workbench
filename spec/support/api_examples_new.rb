require 'spec_helper'

shared_examples :a_new_api_call do |klass|

  it 'should have the expected keys' do

    # first check the top-level keys are the same
    @response_body.keys.should =~ @expected_hash.keys

    # check the expected items are present
    @response_body.should deep_eql @expected_hash
  end

  it 'should not have any extra keys' do
    expected_hash_keys = @expected_hash.keys
    actual_hash_keys = @response_body.keys

    # check that no other keys are there
    actual_hash_keys.reject{|item| expected_hash_keys.include? item }.should be_blank
  end

end