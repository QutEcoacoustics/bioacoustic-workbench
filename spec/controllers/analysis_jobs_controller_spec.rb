require 'spec_helper'

describe AnalysisJobsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisJob
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:analysis_job)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisJob, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :description => nil,
          :name => nil,
          :notes => {},
          :data_set_identifier => nil,
          :script_description => nil,
          :script_display_name => nil,
          :script_extra_data => nil,
          :script_name => nil,
          :script_settings => nil,
          :script_version => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, AnalysisJob
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AnalysisJob.count
        test = convert_model(:create, :analysis_job, build(:analysis_job))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, AnalysisJob
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AnalysisJob.count
        test = convert_model(:create, :analysis_job, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, AnalysisJob, {:name=>["can't be blank", "is too short (minimum is 2 characters)"], :script_name=>["can't be blank"], :script_settings=>["can't be blank"], :script_version=>["can't be blank"], :script_display_name=>["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:analysis_job)
        @changed.name = 'new name, the'
        test = convert_model(:update, :analysis_job, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, AnalysisJob, :name
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:analysis_job)
        @old_value = @initial.name
        @initial.name = ''
        test = convert_model(:update, :analysis_job, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, AnalysisJob, :name, {:name=>["can't be blank", "is too short (minimum is 2 characters)"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, AnalysisJob, :allow_delete , :allow_archive
  end
end

