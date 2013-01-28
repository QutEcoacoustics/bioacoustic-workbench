require 'spec_helper'

describe AnalysisScriptsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisScript
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:analysis_script)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, AnalysisScript, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :description => nil,
          :name => nil,
          :display_name => nil,
          :extra_data => nil,
          :settings => nil,
          :version => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, AnalysisScript
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = AnalysisScript.count
        test = convert_model(:create, :analysis_script, build(:analysis_script))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, AnalysisScript
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = AnalysisScript.count
        test = convert_model(:create, :analysis_script, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, AnalysisScript, {:name=>["can't be blank", "is too short (minimum is 2 characters)", "is invalid"], :display_name=>["can't be blank", "is too short (minimum is 2 characters)"], :version=>["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:analysis_script)
        @changed.display_name = 'a new name for me'
        test = convert_model(:update, :analysis_script, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, AnalysisScript, :display_name
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:analysis_script)
        @old_value = @initial.display_name
        @initial.display_name = ''
        test = convert_model(:update, :analysis_script, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, AnalysisScript, :display_name, {:name=>["can't be blank", "is too short (minimum is 2 characters)", "is invalid"], :display_name=>["can't be blank", "is too short (minimum is 2 characters)"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, AnalysisScript, :allow_delete , :allow_archive

  end
end

