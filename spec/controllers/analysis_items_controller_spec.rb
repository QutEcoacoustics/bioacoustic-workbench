require 'spec_helper'

describe AnalysisItemsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisItem
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:analysis_item)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisItem, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :worker_info => nil,
          :worker_started_utc => nil,
          :worker_run_details => nil,
          :status => 'ready',
          :offset_start_seconds => nil,
          :offset_end_seconds => nil,
          :audio_recording_id => nil,
          :updated_at => nil,
          :created_at => nil
      }
    end

    it_should_behave_like :a_new_api_call, AnalysisItem
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AnalysisItem.count
        test = convert_model(:create, :analysis_item, build(:analysis_item))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, AnalysisItem
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AnalysisItem.count
        test = convert_model(:create, :analysis_item, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, AnalysisItem,  {:offset_start_seconds=>["can't be blank", "is not a number"], :offset_end_seconds=>["can't be blank", "is not a number"], :audio_recording_id=>["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:analysis_item)
        @changed.status = :complete
        test = convert_model(:update, :bookmark, @changed)
        @response_body = json_empty_body(test)
      end

      it_should_behave_like :a_valid_update_api_call, AnalysisItem, :status
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:analysis_item)
        @old_value = @initial.status
        @initial.status = :does_not_exist
        test = convert_model(:update, :analysis_item, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, AnalysisItem, :status,{:status=>["is not included in the list", "can't be blank"]}
    end
  end

  describe "DELETE #destory" do
    context "should be successful for a valid delete call" do
      before(:each) do
        @item = create(:analysis_item)
        @response_body = json_empty_body(convert_model_for_delete(@item))
      end

      it_should_behave_like :a_valid_delete_or_archive_api_call, AnalysisItem, :delete
    end
    context "should not be successful for an invalid delete call" do
      it_should_behave_like :an_invalid_delete_or_archive_api_call, AnalysisItem, :analysis_item, :delete, :invalid_index
    end

    context "should not allow archiving" do
      before(:each) do
        @item = create(:analysis_item)
        @response_body = json_empty_body(convert_model_for_delete(@item))
      end
      it_should_behave_like :an_archive_api_call_when_archive_is_not_allowed, AnalysisItem
      #it_should_behave_like :an_invalid_delete_or_archive_api_call, Bookmark, :bookmark, :archive, :valid_index
    end
  end
end