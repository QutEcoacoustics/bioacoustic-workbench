require 'spec_helper'

describe BookmarksController do
  describe "GET #index" do
    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like :an_idempotent_api_call, Bookmark
  end

  describe "GET #show" do
    before(:each) do
      @item = create(:bookmark)
      @response_body = json({get: :show, id: @item.id})
    end

    it_should_behave_like :an_idempotent_api_call, Bookmark, false
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
        test = convert_model(:create, :bookmark, build(:bookmark))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, Bookmark
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Bookmark.count
        test = convert_model(:create, :bookmark, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, Bookmark, {:offset_seconds => ["can't be blank", "is not a number"], :audio_recording_id => ["can't be blank"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:bookmark)
        @changed.offset_seconds = 500
        test = convert_model(:update, :bookmark, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, Bookmark, :offset_seconds
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:bookmark)
        @old_value = @initial.offset_seconds
        @initial.offset_seconds = -10.0
        test = convert_model(:update, :bookmark, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, Bookmark, :offset_seconds, {:offset_seconds => ["must be greater than or equal to 0"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, Bookmark, :allow_delete #, :allow_archive
  end
end