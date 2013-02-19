require 'spec_helper'

describe ProjectsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Project
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:project)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Project, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :description => nil,
          :name => nil,
          :notes => {},
          :photos => [],
          :sites => [],
          :urn => nil,
          :latitude => nil,
          :longitude => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, Project
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Project.count
        test = convert_model(:create, :project, build(:project))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, Project
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Project.count
        test = convert_model(:create, :project, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, Project, {:name=>["can't be blank"], :urn=>["can't be blank", "is invalid"], :latitude=>["is not a number"], :longitude=>["is not a number"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:project)
        @changed.name = 'my new name'
        test = convert_model(:update, :project, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, Project, :name
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:project)
        @old_value = @initial.urn
        @initial.urn = 'invalid'
        test = convert_model(:update, :project, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, Project, :urn, {:urn=>["is invalid"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, Project, :allow_archive #, :allow_delete

  end
end