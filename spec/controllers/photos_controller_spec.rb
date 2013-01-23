require 'spec_helper'



describe PhotosController do
  describe 'GET #index' do

    before(:each) do
      @response_body = json get: :index
    end

    it_should_behave_like  :an_idempotent_api_call, Photo
  end

  describe "GET #show" do
    before(:each) do
      item = random_item
      @response_body = json({ get: :show, id: item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Photo, false
  end

  describe 'GET #new' do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          :description => nil,
          :copyright => nil,
          :imageable_id => nil,
          :imageable_type => nil,
          :uri => nil,
          :updated_at => nil,
          :created_at => nil
      }
    end

    it_should_behave_like :a_new_api_call, Photo
  end

  describe "POST #create" do
    context "with valid attributes" do
      before(:each) do
        @initial_count = Photo.count
        @response_body = json({ post: :create, photo: build(:photo).attributes })
      end

      it_should_behave_like :a_valid_create_api_call, Photo
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Photo.count
        @response_body = json({ post: :create, photo: {} })
      end

      it_should_behave_like :an_invalid_create_api_call, Photo, {:uri=>["can't be blank", "is invalid"], :copyright=>["can't be blank"]}
    end
  end

  describe 'PUT #update' do
    it 'exists in the database'

    context 'with valid attributes' do
      it 'updates the existing item in the database'
      it 'returns with empty body and with status 200'
    end

    context 'with invalid attributes' do
      it 'does not update the existing item in the database'
      it 'renders the error in json with expected properties, with status 422'
    end
  end

  describe 'DELETE #destory' do
    it 'finds the correct item fromthe database and assigns it to the local variable'
    it 'destories the correct item, and the database is updated'
    it 'returns with empty body and with status 200'
  end
end

=begin
require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  setup do
    @photo = Photo.first!
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:photos)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create photo' do
    assert_difference('Photo.count') do
      post :create, photo: { copyright: @photo.copyright, uri: @photo.uri }
    end

    assert_redirected_to photo_path(assigns(:photo))
  end

  test 'should show photo' do
    get :show, id: @photo
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @photo
    assert_response :success
  end

  test 'should update photo' do
    @old_name = @photo.description
	@new_name = @photo.description + ' more text!'
    put :update, id: @photo, photo: { copyright: (@photo.copyright + 'a change!'), uri: @photo.uri, description: @new_name }
    
	assert_equal @new_name, assigns(:photo).description
	assert_redirected_to photo_path(assigns(:photo))
  end

  test 'should destroy photo' do
    assert_difference('Photo.count', -1) do
      delete :destroy, id: @photo
    end

    assert_redirected_to photos_path
  end
end
=end