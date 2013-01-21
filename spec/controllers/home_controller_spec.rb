require 'spec_helper'

describe HomeController do
  describe "GET #index using json returns 406" do
    before(:each) do
      @response_body = get :index, { format: :json }
    end

    it { should respond_with(:not_acceptable) }

    it 'responds with empty body' do
      @response.body.should be_blank
    end

  end

  describe "GET #index using html returns 200" do
    before(:each) do
      @response_body = get :index
    end

    it { should respond_with(:success) }

    it 'responds with html' do
      response.header['Content-Type'].should include 'html'
    end

  end
end