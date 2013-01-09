require 'spec_helper'

projects_controllers_path = "/projects"

describe "AuthenticationProcess" do

  context "html requests" do



    describe "GET /projects_controllers" do
      it "works! (now write some real specs)" do
        # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
        get projects_controllers_path
        response.status.should be(200)
      end
    end
  end
end
