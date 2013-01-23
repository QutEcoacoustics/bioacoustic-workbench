require 'spec_helper'

describe PermissionsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Permission
  end

  describe "GET #show" do
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Permission, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :level => 'none',
          :permissionable_id => nil,
          :permissionable_type => nil,
          :user_id => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, Permission
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Permission.count
        @response_body = json({ post: :create, permission: build(:permission).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, Permission
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Permission.count
        @response_body = json({ post: :create, permission: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, Permission, {}
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

class PermissionsControllerTest < ActionController::TestCase
  setup do
    @permission = Permission.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permission" do
    assert_difference('Permission.count') do
      post :create, permission: { level: @permission.level }
    end

    assert_redirected_to permission_path(assigns(:permission))
  end

  test "should show permission" do
    get :show, id: @permission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permission
    assert_response :success
  end

  test "should update permission" do
    put :update, id: @permission, permission: { level: @permission.level }
    assert_redirected_to permission_path(assigns(:permission))
  end

  test "should destroy permission" do
    assert_difference('Permission.count', -1) do
      delete :destroy, id: @permission
    end

    assert_redirected_to permissions_path
  end
end
=end