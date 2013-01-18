require 'spec_helper'

describe PhotosController do
  describe 'GET #index' do

    before(:each) do
      get :index, { :format => :json }
      @response_body = JSON.parse(response.body)
    end

    it {should respond_with(:success) }

    it 'should be a list' do
      @response_body.should have(Photo.count).photos
    end

    it 'should be an array' do
      @response_body.kind_of?(Array).should be_true
    end

    it 'should not be a single item' do
      @response_body.kind_of?(Hash).should_not be_true
    end

    it 'should not be empty' do
      @response_body.blank?.should_not be_true
    end

  end

  describe 'GET #show' do
    it 'assigns the requested item to the local variable'
    it 'renders the item in json with the expected properties'
  end

  describe 'GET #new' do
    it 'assigns a new item to the local variable'
    it 'renders the item in json with the expected properties'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new item in the database'
      it 'renders the new item in json with the expect properties, with status 201, with location header'
    end

    context 'with invalid attributes' do
      it 'does not save the new item in the database'
      it 'renders the error in json with expected properties, with status 422'
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