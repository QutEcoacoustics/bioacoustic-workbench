require 'spec_helper'

shared_examples :a_valid_update_api_call do |klass, changed_attribute_name|

  it { should respond_with(:no_content) }

  it { should respond_with_content_type(:json) }

  it 'should update the item and ensure updater_id is set and updated_at has change' do
    item_from_db = klass.find_by_id(@changed[:id])

    # see this for more info: https://github.com/delynn/userstamp/blob/master/test/stamping_test.rb
    if item_from_db.respond_to?('updater_id')
      item_from_db.updater_id.should_not be_blank
    end

    item_from_db.updated_at.should_not be_blank
    item_from_db.updated_at.should > @changed[:updated_at]

    item_from_db[changed_attribute_name].should == @changed[changed_attribute_name]
    #@initial.attributes.should deep_eql item_from_db.attributes
  end

  it 'should not have any errors in response' do
    if @response.status != 204 # no content
      fail "Wrong http status code. Expected 204, got #{@response.status}. Body: #{@response.body}"
    end
  end

  it 'should ensure updater_id is blank in submitted model object' do
    # @changed is the newly-created model object,
    # it has never been modified, so it won't have an updater_id yet
    if @changed.respond_to?('updater_id')
      @changed.updater_id.should be_blank
    end
  end

end

shared_examples :an_invalid_update_api_call do |klass, changed_attribute_name, expected_error|

  it { should respond_with(:unprocessable_entity) }

  it { should respond_with_content_type(:json) }

  it 'should be a hash' do
    @response_body.should be_an_instance_of(Hash)
  end

  it 'should return the expected error information' do
    @response_body.should deep_eql expected_error
  end

  it 'should not update the database' do
    item_from_db = klass.find_by_id(@initial[:id])

    item_from_db[changed_attribute_name].should == @old_value

    if item_from_db.respond_to?('updater_id')
      item_from_db.updater_id.should be_blank
    end
    item_from_db.updated_at.should_not be_blank
    item_from_db.updated_at.should == @initial[:updated_at]

    #@initial.attributes.should deep_eql item_from_db.attributes
  end

end