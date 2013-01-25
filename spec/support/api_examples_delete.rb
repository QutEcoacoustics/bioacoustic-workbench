require 'spec_helper'
# invalid: well-formed vs can-we-do-this. We might pass a well-formed klass, but the action is not allowed.
shared_examples :a_valid_delete_or_archive_api_call do |klass, archive_or_delete = 'delete'.to_sym|

  it { should respond_with(:no_content) }
  it { should respond_with_content_type(:json) }
  it "should #{archive_or_delete == :archive ? '' : 'NOT'} return the archived_at date as a header" do
    has_header = @response.headers.include?('X-Archived-At')

    if archive_or_delete == :archive
      has_header.should be_true
    else
      has_header.should be_false
    end
  end

  if archive_or_delete == :archive
    it 'should archive the correct record by updating the deleted_at' do
      item_from_db = klass.find_by_id(@item[:id])
      item_from_db.deleted_at.should_not be_blank
    end
    it 'should archive the correct record by updating the deleter_id' do
      item_from_db = klass.find_by_id(@item[:id])
      item_from_db.deleter_id.should_not be_blank
    end
    it 'should not be returned by default when a query (model) would include it' do
      klass.where(:id => @item[:id]).all.should be_empty
    end
    it 'should not be returned by default when a request (controller) is made for it\'s id' do
      @response_body2 = json_empty_body(convert_model_for_delete(@item))
      @response
    end
  else
    it 'should delete the correct record in the database' do
      klass.find_by_id(@item[:id]).should == nil
    end
  end
end

# invalid: well-formed vs can-we-do-this. We might pass a well-formed request, but the action is not allowed.
shared_examples :an_invalid_delete_or_archive_api_call do |klass, model_symbol, archive_or_delete = 'delete'.to_sym, use_a_real_item = 'valid_index'.to_sym|

  before(:each) do
    exists = use_a_real_item == :valid_index

    if exists
      @item = create(model_symbol)
    end
    @item_count = klass.count
    @id_to_test = exists ? @item.id : -30

    #@exists = !klass.where(:id => @id_to_test).first.blank?

    if exists
      @response_body = json_empty_body(convert_model_for_delete({id: @id_to_test}))
    end
  end

  it "should #{use_a_real_item == :valid_index ? 'NOT' : ''} raise the expected error if the id does #{use_a_real_item == :valid_index ? '' : 'NOT'} exist" do
    if use_a_real_item == :valid_index
      true.should be_true, 'the id exists. The universe is safe. yay!'
    else
      expect {
        json_empty_body(convert_model_for_delete({id: @id_to_test}))
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  if use_a_real_item == :valid_index
    it { should respond_with(:no_content) }
    it { should respond_with_content_type(:json) }

    it 'should be empty' do
      @response.body.should be_blank
    end

    it 'should return the expected response if the id does exist' do
      if archive_or_delete == :delete
          #@response.status.should == :method_not_allowed
        # todo test for allow
      elsif archive_or_delete == :archive
        # this will only happen if deletes and archives are not allowed
        #@response.status.should == :method_not_allowed
        #@response.headers.include?
        fail 'implement invalid delete verb (that\'s me)'
      end
    end

    if archive_or_delete == :archive

      it 'should not archive the record by updating the deleted_at' do
        klass.where(:id => @id_to_test).should be_empty
      end

      it 'should not archive the record by updating the deleter_id' do
        klass.where(:id => @id_to_test).should be_empty
      end

    end

  else

    it 'should not return any response if the id does not exist' do
      expect {
         json_empty_body(convert_model_for_delete({id: @id_to_test}))
      }.to raise_error(ActiveRecord::RecordNotFound)
      @response.body.should be_blank
    end
  end

  it 'should NOT delete the record' do
    klass.count.should == @item_count
  end
end

shared_examples :getting_a_valid_archive_api_call do |klass|
#permisisons?

  it 'should be returned when a query includes it and specifies to include archived items'
  it 'should have deleted_at and deleter_id set'

  # use the idempotent api call examples
  it_should_behave_like :an_idempotent_api_call, klass, false

end

shared_examples :an_archive_api_call_when_archive_is_not_allowed do |klass|
  it 'should not have deleted_id attribute' do
    @item.respond_to?('deleted_id').should be_false
  end
  it 'should not have deleted_at attribute' do
    @item.respond_to?('deleted_at').should be_false
  end
  it 'should be deleted' do
    klass.where(:id => @item[:id]).first.should == nil
  end
end