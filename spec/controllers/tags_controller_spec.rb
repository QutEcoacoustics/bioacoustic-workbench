require 'spec_helper'

describe TagsController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Tag
  end

  describe "GET #show" do
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Tag, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :deleted_at => nil,
          :deleter_id => nil,
          :is_taxanomic => false,
          :text => nil,
          :type_of_tag => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, Tag
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Tag.count
        @response_body = json({ post: :create, tag: build(:tag).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, Tag
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Tag.count
        @response_body = json({ post: :create, tag: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, Tag, {:type_of_tag=>["can't be blank"], :text=>["text must not be nil"]}
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

class TagsControllerTest < ActionController::TestCase
  setup do
    @tag = Tag.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      post :create, tag: { is_taxanomic: @tag.is_taxanomic, text: @tag.text, type_of_tag: @tag.type_of_tag }
    end

    assert_redirected_to tag_path(assigns(:tag))
  end

  test "should show tag" do
    get :show, id: @tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tag
    assert_response :success
  end

  test "should update tag" do
    put :update, id: @tag, tag: { is_taxanomic: @tag.is_taxanomic, text: @tag.text, type_of_tag: @tag.type_of_tag }
    assert_redirected_to tag_path(assigns(:tag))
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete :destroy, id: @tag
    end

    assert_redirected_to tags_path
  end
end
=end