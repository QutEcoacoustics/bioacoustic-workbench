require 'spec_helper'

describe ProjectsController do

    before do
      # sign user in
      #@rocket = Rocket.new
    end

    describe "GET #index" do
      it "should return a list of projects" do
        get :index

        response.should redirect_to
      end
    end



end
