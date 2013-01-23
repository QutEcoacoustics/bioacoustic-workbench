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
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Site, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :audio_recordings => [],
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
        @response_body = json({ post: :create, site: build(:site).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, Site
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Site.count
        @response_body = json({ post: :create, site: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, Site, {:name=>["can't be blank", "is too short (minimum is 2 characters)"], :latitude=>["is not a number"], :longitude=>["is not a number"]}
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

class SitesControllerTest < ActionController::TestCase
  setup do
    @site = Site.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site" do
    assert_difference('Site.count') do
      post :create, site: { latitude: @site.latitude, longitude: @site.longitude, name: @site.name, notes: @site.notes }
    end

    assert_redirected_to site_path(assigns(:site))
  end

  test "should show site" do
    get :show, id: @site
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site
    assert_response :success
  end

  test "should update site" do
    put :update, id: @site, site: { latitude: @site.latitude, longitude: @site.longitude, name: @site.name, notes: @site.notes }
    assert_redirected_to site_path(assigns(:site))
  end

  test "should destroy site" do
    assert_difference('Site.count', -1) do
      delete :destroy, id: @site
    end

    assert_redirected_to sites_path
  end
end
=end