shared_examples :getting_a_valid_archive_api_call do |klass|

  ## TODO: FINISH THIS FILE, IMPLEMENT INTO CONTROLLERS
  # WARN: INCOMPLETE


  #it 'should be returned when a query includes it and specifies to include archived items' do

  #end
  it 'should have deleted_at and deleter_id set' do
    @item.respond_to?('deleter_at').should be_true
    @item.respond_to?('deleter_id').should be_true

    @item.deleter_id.should_not be_nil
    @item.deleted_at.should_not be_nil

  end



  # use the idempotent api call examples
  #

  context 'indempotent call, many, with archive, should work' do
    before(:each) do
      # TODO, set the header somehow ARCHIVED_HEADER

      @item = create(:audio_recording)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like :an_idempotent_api_call, klass, true
  end
  context 'indempotent call, single, with archive, should work'  do
    before(:each) do
      # TODO, set the header somehow ARCHIVED_HEADER

      @item = create(:audio_recording)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like :an_idempotent_api_call, klass, false
  end
  context 'create call, with archive, should not work'
  context 'modify call, with archive, should work'

  # deleting tested in api_examples_delete.rb

end