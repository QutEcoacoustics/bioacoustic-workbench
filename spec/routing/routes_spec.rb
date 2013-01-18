require "spec_helper"

routes_to_test=
    {
        "/analysis_items"   => [:get, "analysis_items", "index"],
        "/analysis_jobs"    => [:get, "analysis_jobs", "index"],
        "/analysis_scripts" => [:get, "analysis_scripts", "index"],
        "/audio_events"     => [:get, "audio_events", "index"],
        "/audio_recordings" => [:get, "audio_recordings", "index"],
        "/bookmarks"        => [:get, "bookmarks", "index"],
        # home has different behaviour, test separately
        "/media"            => [:get, "media", "index"],
        "/permissions"      => [:get, "permissions", "index"],
        "/photos"           => [:get, "photos", "index"],
        "/progresses"         => [:get, "progresses", "index"],
        "/projects"         => [:get, "projects", "index"],
        "/saved_searches"   => [:get, "saved_searches", "index"],
        "/sites"            => [:get, "sites", "index"],
        "/tags"             => [:get, "tags", "index"],
        "/users"            => [:get, "users", "index"]

    }

describe "routes for html requests" do

  routes_to_test.each { |path, options|
    it "routes #{path} to the home\#index action" do

      # note, these are html requests, they should not route to their controllers
      # so ignore options[1] and options[2]

      { options[0] => path }.
          should route_to(:controller => "home", :action => "index", :path => path.slice(1..-1))
    end
  }


  it "should not route assets" do
    { :get => "/assets/application.css" }.should_not be_routable
  end

  it "should route the assets folder" do
    { :get => "/assets" }.should route_to(:controller => "home", :action => "index", :path => "assets")
  end

  security_routes = {
      "/security/auth/open_id"       => ["api/callbacks", "passthru", "open_id"],
      "/security/auth/facebook"      => ["api/callbacks", "passthru", "facebook"],
      "/security/auth/browser_id"    => ["api/callbacks", "passthru", "browser_id"],
      "/security/auth/google_oauth2" => ["api/callbacks", "passthru", "google_oauth2"],
      "/security/auth/twitter"       => ["api/callbacks", "passthru", "twitter"],

      "/security/sign_in"            => ["api/sessions", "new"],
      "/security/sign_out"           => ["api/sessions", "destroy"]
  }

  context "devise security routes" do

    security_routes.each { |route, controller|

      it "should route #{route} the #{controller[0]}\##{controller[1]} action" do
        route_hash = {:controller => controller[0], :action => controller[1]}
        route_hash[:provider] = controller[2] if controller[2]
        { :get => route }.should route_to(route_hash)
      end
    }

  end

end


describe "routes for json requests" do

  #########
  #
  #        BECAUSE RAILS TESTING IS SHIT, WE CAN'T SPECIFY A CUSTOM HTTP HEADER AND DO AN
  #        assert_recognizes ON THE ROUTE TO TEST IT. SO WE MESS WITH ITS DEFAULTS!!!
  #
  #########
  before do
    Rack::MockRequest::DEFAULT_ENV["HTTP_ACCEPT"] = "application/json"
  end

  after do
    Rack::MockRequest::DEFAULT_ENV.delete "HTTP_ACCEPT"
  end

  it "should route projects to the projects controller" do
    { :get => '/projects' }.should route_to(:controller => "projects", :action => "index")
  end

  routes_to_test.each { |path, options|
    it "routes #{path} to the #{options[1]} action" do
      { options[0] => path }.
          should route_to(:controller => options[1], :action => options[2])
    end
  }

end



