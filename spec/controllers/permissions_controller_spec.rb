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
      @item = create(:permission)
      @response_body = json({ get: :show, id: @item.id })
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
        test = convert_model(:create, :permission, build(:permission))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, Permission
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Permission.count
        test = convert_model(:create, :permission, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, Permission, {:offset_seconds => ["can't be blank", "is not a number"], :audio_recording_id => ["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:permission)
        @changed.level = :owner
        test = convert_model(:update, :permission, @changed)
        @response_body = json_empty_body(test)
      end

      it_should_behave_like :a_valid_update_api_call, Permission, :level
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:permission)
        @old_value = @initial.level
        @initial.level = :does_not_exist
        test = convert_model(:update, :permission, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, Permission, :level, {:offset_seconds => ["must be greater than or equal to 0"]}
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