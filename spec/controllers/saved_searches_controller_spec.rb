require 'spec_helper'

describe SavedSearchesController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, SavedSearch
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:saved_search)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, SavedSearch, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :name => nil,
          :owner_id => nil,
          :search_object => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, SavedSearch
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = SavedSearch.count
        #hash = { put: :create, bookmark: remove_timestamp_fields(build(:bookmark).attributes)}
        test = convert_model(:create, :saved_search, build(:saved_search))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, SavedSearch
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = SavedSearch.count
        #hash = { put: :create, bookmark: {} }
        test = convert_model(:create, :saved_search, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, SavedSearch, {:search_object=>["can't be blank", "search_object not in json format"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:saved_search) # this saves it to the db
        @changed.name = 'my new name, this is new, it must be' # change it
        #hash = { put: :update, id: @changed.id, bookmark: remove_timestamp_fields(@changed.attributes.clone) }
        test = convert_model(:update, :saved_search, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, SavedSearch, :search_object
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:saved_search)
        @old_value = @initial.search_object
        @initial.search_object = 'this is not right' # change it to an invalid value
        #hash = { put: :update, id: @initial.id, bookmark: remove_timestamp_fields(@initial.attributes.clone)}
        test = convert_model(:update, :saved_search, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, SavedSearch, :search_object, {:search_object=>["search_object not in json format"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, SavedSearch, :allow_delete #, :allow_archive

  end
end