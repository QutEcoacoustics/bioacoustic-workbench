require 'spec_helper'

describe SavedSearchesController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :a_standard_api_call, SavedSearch
  end

  describe "GET #show" do
    it "assigns the requested item to the local variable"
    it "renders the item in json with the expected properties"
  end

  describe "GET #new" do
    it "assigns a new item to the local variable"
    it "renders the item in json with the expected properties"
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new item in the database"
      it "renders the new item in json with the expect properties, with status 201, with location header"
    end

    context "with invalid attributes" do
      it "does not save the new item in the database"
      it "renders the error in json with expected properties, with status 422"
    end
  end

  describe "PUT #update" do
    it 'exists in the database'

    context "with valid attributes" do
      it "updates the existing item in the database"
      it "returns with empty body and with status 200"
    end

    context "with invalid attributes" do
      it "does not update the existing item in the database"
      it "renders the error in json with expected properties, with status 422"
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