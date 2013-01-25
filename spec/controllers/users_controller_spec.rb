require 'spec_helper'

describe UsersController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, User
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:user)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, User, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :admin => false,
          :created_at => nil,
          :creator_id => nil,
          :display_name => nil,
          :email => '',
          :id => nil,
          :invitation_token => nil,
          :updated_at => nil,
          :updater_id => nil,
          :user_name => nil
      }
    end

    it_should_behave_like :a_new_api_call, User
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = User.count
        test = convert_model(:create, :user, build(:user), %w(confirmation_token confirmed_at confirmation_sent_at unconfirmed_email encrypted_password password_salt failed_attempts unlock_token locked_at reset_password_token reset_password_sent_at remember_created_at authentication_token sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip invitation_token))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, User
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = User.count
        test = convert_model(:create, :user, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, User, {:email=>["can't be blank", "Basic email validation failed. It should have at least 1 `@` and 1 `.`"], :password=>["can't be blank"], :user_name=>["can't be blank"], :display_name=>["Please provide a display name, email, or both."]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:user)
        @changed.user_name = ''
        test = convert_model(:update, :user, @changed, %w(confirmation_token confirmed_at confirmation_sent_at unconfirmed_email encrypted_password password_salt failed_attempts unlock_token locked_at reset_password_token reset_password_sent_at remember_created_at authentication_token sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip invitation_token))
        @response_body = json_empty_body(test)
      end

      it_should_behave_like :a_valid_update_api_call, User, :user_name
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:user)
        @old_value = @initial.user_name
        @initial.user_name = -10.0
        #hash = { put: :update, id: @initial.id, bookmark: remove_timestamp_fields(@initial.attributes.clone)}
        test = convert_model(:update, :user, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, User, :user_name, {:offset_seconds => ["must be greater than or equal to 0"]}
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

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { display_name: @user.display_name }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { display_name: @user.display_name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
=end