require 'spec_helper'

shared_examples :a_valid_create_api_call do |klass|

  it { should respond_with(:created) }

  it { should respond_with_content_type(:json) }

  it 'should create one new item' do
    @initial_count.should == klass.count - 1
  end

  it 'should not have any errors in response' do
    if @response.status != 201
      fail "Wrong http status code #{@response.status}. Body: #@response_body."
    end
  end

  it 'should ensure creator_id and created_at are set' do
    @response_body[:creator_id].should_not be_blank
    @response_body[:created_at].should_not be_blank
  end

  it 'should ensure updater_id and updated_at are set' do
    @response_body[:updater_id].should_not be_blank
    @response_body[:updated_at].should_not be_blank
  end

end

shared_examples :an_invalid_create_api_call do |klass, expected_error|

  it { should respond_with(:unprocessable_entity) }

  it { should respond_with_content_type(:json) }

  it 'should be a hash' do
    @response_body.should be_an_instance_of(Hash)
  end

  it 'should return the expected error information' do
    @response_body.should deep_eql expected_error
  end

end