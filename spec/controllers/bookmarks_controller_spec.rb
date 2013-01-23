require 'spec_helper'

describe BookmarksController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Bookmark
  end

  describe "GET #show" do
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Bookmark, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :name => nil,
          :notes => {},
          :audio_recording_id => nil,
          :offset_seconds => nil,
          :updated_at => nil,
          :created_at => nil,
          :updater_id => nil,
          :creator_id => nil
      }
    end

    it_should_behave_like :a_new_api_call, Bookmark
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Bookmark.count
        hash = {}
        hash[:bookmark] = remove_timestamp_fields(build(:bookmark).attributes)
        hash[:put] = :create
        @response_body = json(hash)
      end

      it_should_behave_like :a_valid_create_api_call, Bookmark
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Bookmark.count
        hash = {}
        hash[:bookmark] = {}
        hash[:put] = :create
        @response_body = json(hash)
      end

      it_should_behave_like :an_invalid_create_api_call, Bookmark, {:offset_seconds=>["can't be blank", "is not a number"], :audio_recording_id=>["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:bookmark) # this saves it to the db
        @new_value = 500
        @changed.offset_seconds = @new_value # change it
        hash = {}
        hash[:bookmark] = remove_timestamp_fields(@changed.attributes.clone)
        hash[:id] = @changed.id
        hash[:put] = :update
        @response_body = json_empty_body(hash)
      end

      it_should_behave_like :a_valid_update_api_call, Bookmark, :offset_seconds
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:bookmark) # this saves it to the db
        @old_value = @initial.offset_seconds
        @initial.offset_seconds = -10.0 # change it
        hash = {}
        hash[:bookmark] = remove_timestamp_fields(@initial.attributes.clone)
        hash[:id] = @initial.id
        hash[:put] = :update
        @response_body = json(hash)
      end

      it_should_behave_like :an_invalid_update_api_call, Bookmark, :offset_seconds, {:offset_seconds=>["must be greater than or equal to 0"]}
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

class BookmarksControllerTest < ActionController::TestCase
  setup do
    @bookmark = Bookmark.first!
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark" do
    assert_difference('Bookmark.count') do
      post :create, bookmark: { name: @bookmark.name, notes: @bookmark.notes, offset: @bookmark.offset }
    end

    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should show bookmark" do
    get :show, id: @bookmark
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmark
    assert_response :success
  end

  test "should update bookmark" do
    put :update, id: @bookmark, bookmark: { name: @bookmark.name, notes: @bookmark.notes, offset: @bookmark.offset }
    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  test "should destroy bookmark" do
    assert_difference('Bookmark.count', -1) do
      delete :destroy, id: @bookmark
    end

    assert_redirected_to bookmarks_path
  end
end
=end