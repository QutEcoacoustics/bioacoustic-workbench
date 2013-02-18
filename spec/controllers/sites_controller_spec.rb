require 'spec_helper'

describe SitesController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Site
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:site)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Site, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          #:audio_recordings => [], # not included - way too many. Maybe some summary stats?
          :latitude => nil,
          :longitude => nil,
          :projects => [],
          :name => nil,
          :notes => {},
          :photos => [],
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, Site
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Site.count
        #hash = { put: :create, bookmark: remove_timestamp_fields(build(:bookmark).attributes)}
        test = convert_model(:create, :site, build(:site))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, Site
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Site.count
        #hash = { put: :create, bookmark: {} }
        test = convert_model(:create, :site, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, Site, {:name=>["can't be blank", "is too short (minimum is 2 characters)"], :latitude=>["is not a number"], :longitude=>["is not a number"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:site) # this saves it to the db
        @changed.name = 'my new name, this is new, it must be' # change it
        #hash = { put: :update, id: @changed.id, bookmark: remove_timestamp_fields(@changed.attributes.clone) }
        test = convert_model(:update, :site, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, Site, :name
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:site)
        @old_value = @initial.name
        @initial.name = 'a' # change it to an invalid value
        #hash = { put: :update, id: @initial.id, bookmark: remove_timestamp_fields(@initial.attributes.clone)}
        test = convert_model(:update, :site, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, Site, :name, {:name=>["is too short (minimum is 2 characters)"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, Site, :allow_archive #, :allow_delete

  end
end