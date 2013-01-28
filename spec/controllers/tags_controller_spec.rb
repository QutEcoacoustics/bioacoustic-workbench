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
      @item = create(:tag)
      @response_body = json({ get: :show, id: @item.id })
    end

    it_should_behave_like  :an_idempotent_api_call, Tag, false
  end

  describe "GET #new" do
    before(:each) do
      @response_body = json get: :new
      @expected_hash = {
          :id => nil,
          #:deleted_at => nil,
          #:deleter_id => nil,
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
        test = convert_model(:create, :tag, build(:tag))
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_create_api_call, Tag
    end

    context "with invalid attributes" do
      before(:each) do
        @initial_count = Tag.count
        test = convert_model(:create, :tag, nil)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_create_api_call, Tag, {:type_of_tag=>["is not included in the list", "can't be blank"], :text=>["text must not be nil"]}
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      before(:each) do
        @changed = create(:tag)
        @changed.type_of_tag = :common_name
        test = convert_model(:update, :tag, @changed)
        @response_body = json(test)
      end

      it_should_behave_like :a_valid_update_api_call, Tag, :type_of_tag
    end

    context "with invalid attributes" do
      before(:each) do
        @initial = create(:tag)
        @old_value = @initial.type_of_tag
        @initial.type_of_tag = :this_does_not_exist
        test = convert_model(:update, :tag, @initial)
        @response_body = json(test)
      end

      it_should_behave_like :an_invalid_update_api_call, Tag, :type_of_tag, {:type_of_tag=>["is not included in the list", "can't be blank"]}
    end
  end

  describe "DELETE #destory" do
    it_should_behave_like :a_delete_api_call, Tag, :allow_delete #, :allow_archive

  end
end