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
        @response_body = json_empty_body(test)
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
    it "finds the correct item fromthe database and assigns it to the local variable"
    it 'destories the correct item, and the database is updated'
    it "returns with empty body and with status 200"
  end
end


=begin
require 'test_helper'

class SavedSearchesControllerTest < ActionController::TestCase
  setup do
    @saved_search = SavedSearch.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:saved_searches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saved_search" do
    assert_difference('SavedSearch.count') do
      post :create, saved_search: { name: @saved_search.name, search_object: @saved_search.search_object }
    end

    assert_redirected_to saved_search_path(assigns(:saved_search))
  end

  test "should show saved_search" do
    get :show, id: @saved_search
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saved_search
    assert_response :success
  end

  test "should update saved_search" do
    put :update, id: @saved_search, saved_search: { name: @saved_search.name, search_object: @saved_search.search_object }
    assert_redirected_to saved_search_path(assigns(:saved_search))
  end

  test "should destroy saved_search" do
    assert_difference('SavedSearch.count', -1) do
      delete :destroy, id: @saved_search
    end

    assert_redirected_to saved_searches_path
  end
end
=end