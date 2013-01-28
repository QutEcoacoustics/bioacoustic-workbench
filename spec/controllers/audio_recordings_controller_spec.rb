require 'spec_helper'

describe AudioRecordingsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AudioRecording
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:audio_recording)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AudioRecording, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :notes => {},
          :bit_rate_bps => nil,
          :channels => nil,
          :data_length_bytes => nil,
          :duration_seconds => nil,
          :file_hash => nil,
          :media_type => nil,
          :recorded_date => nil,
          :sample_rate_hertz => nil,
          #:site_id => nil,
          :site => nil,
          :status => 'new',
          :uploader_id => nil,
          :uuid => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, AudioRecording
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AudioRecording.count
        test = convert_model(:create, :audio_recording, build(:audio_recording), [:uuid])
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, AudioRecording
    end

    it 'should not allow mass assignment of the uuid attribute' do
      expect {
        json convert_model(:create, :audio_recording, build(:audio_recording))
      }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AudioRecording.count
        test = convert_model(:create, :audio_recording, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, AudioRecording, {:status=>["is not included in the list", "can't be blank"], :uploader_id=>["can't be blank"], :recorded_date=>["can't be blank", "is not a valid date"], :site=>["can't be blank"], :duration_seconds=>["can't be blank", "is not a number"], :sample_rate_hertz=>["is not a number"], :channels=>["can't be blank", "is not a number"], :bit_rate_bps=>["is not a number"], :media_type=>["can't be blank"], :data_length_bytes=>["can't be blank", "is not a number"], :file_hash=>["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:audio_recording)
        @changed.status = :to_check
        test = convert_model(:update, :audio_recording, @changed, [:uuid])
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, AudioRecording, :status
    end

    it 'should not allow mass assignment of the uuid attribute' do
      expect {
        json convert_model(:update, :audio_recording, build(:audio_recording))
      }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:audio_recording)
        @old_value = @initial.status
        @initial.status = :does_not_exist
        test = convert_model(:update, :audio_recording, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, AudioRecording, :status, {:offset_seconds => ["must be greater than or equal to 0"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, AudioRecording, :allow_archive #, :allow_delete

  end




end

