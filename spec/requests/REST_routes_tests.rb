require "spec_helper"


#########
#
#        BECAUSE RAILS TESTING IS SHIT, WE CAN'T SPECIFY A CUSTOM HTTP HEADER AND DO AN
#        assert_recognizes ON THE ROUTE TO TEST IT. SO ALL OF THE ROUTE TESTS FOR OUR
#        REST API ARE NOW INTEGRATION TESTS!!!
#
#########


describe "routes for json requests" do

  before do
    #ActionDispatch::TestRequest::DEFAULT_ENV["action_dispatch.request.accepts"] = "application/json"
    request.env['HTTP_ACCEPT'] = "application/json"
    RACK::MOCK::
        end

    after do
      #ActionDispatch::TestRequest::DEFAULT_ENV.delete("action_dispatch.request.accepts")
      request.env['HTTP_ACCEPT'] = "*/*"
    end

    it "should route projects to the projects controller" do
      head "/projects.json"

      route_to(:controller => "projects_controller", :action => "index")
      #assert_recognizes({:controller => 'items', :action => 'index'}, 'items')
    end

  end
end



