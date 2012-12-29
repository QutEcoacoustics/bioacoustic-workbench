class AngularConstraint
  def initialize
    @exceptions = [/^\/assets\/.*/, /^\/security\/.*/ ]
  end

  # if any html request comes through then match it
  # unless it is in the assets path
  def matches?(request)
    # this treats */* as html request
    return false unless request.format
    return false unless request.format.html?

    @exceptions.each {|p|
      return false if p.match request.path
    }

     true
  end
end

BawSite::Application.routes.draw do

  resources :analysis_items


  # this is the catch-all route that allows rails to respond to any route, and essentially 'forward' it to angular
  match '*path' => 'home#index', :constraints => AngularConstraint.new, :as => :angular_routing

  # devise route configuration
  # documentation at rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper:devise_for
  # skipping generating session controller because we want sessions off completely
  # skipping registrations because we use external providers (and required local auth'd users are seeded)
  # skip_helpers => true stops /security/signout from working!
  devise_for :users, :path => 'security',  :skip => [ :registrations], :skip_helpers => [ :registrations],
             :controllers => { :sessions => 'api/sessions',:omniauth_callbacks => 'api/callbacks',
                               :registrations => 'api/registrations', :confirmations => 'api/confirmations' }


  devise_scope :user do
    # add a route for the ping action
    match '/security/ping' => 'api/sessions#ping', :via => [:get]
    # add a route for sending additional information from a prompt after authenticating with an external provider
    #match '/security/auth/additional_info' => 'api/callbacks#additional_info', :via => [:get]
  end

  resources :home, :projects, :sites, :photos, :users, :audio_recordings, :permissions,
            :tags, :bookmarks,  :progresses, :saved_searches, :analysis_jobs, :analysis_scripts

  resources :audio_recordings do
    collection do
      get 'new'
    end
    member do
      # for when harvester has moved a file to the correct location
      post 'upload_complete'
    end
  end

  resources :audio_events do
    collection do
      get 'download'
    end
  end
  
  # audio and spectrogram media items
  # (?<id>[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})_(?<start_offset>\d{9})_(?<end_offset>\d{9})_(?<channel>\d{1,4})_(?<sample_rate>\d{1,6}).(?<format>\S{1,4})
  # audio: http://localhost:3000/media/21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_012345678_1024_100000.webma
  # image: http://localhost:3000/media/21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_012345678_1024_100000_1024_g.png
  match 'media' => 'media#index'

  # for updating audio recording info in development database only
  get 'media/update'

  DECIMAL_REGEXP = /\d{1,9}(\.\d{1,6})?/

  # for cached spectrograms
  match 'media/(:id)_(:start_offset)_(:end_offset)_(:channel)_(:sample_rate)_(:window)_(:colour)' => 'media#item',
    :constraints => { 
      :id              => /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/,
      :start_offset    => DECIMAL_REGEXP,
      :end_offset      => DECIMAL_REGEXP,
      :channel         => /\d{1,4}/,
      :sample_rate     => /\d{1,6}/,
      :window          => /\d{1,4}/,
      :colour          => /[a-zA-Z]/
    }
  
  # for cached audio
  match 'media/(:id)_(:start_offset)_(:end_offset)_(:channel)_(:sample_rate)' => 'media#item',
    :constraints => { 
      :id              => /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/,
      :start_offset    => DECIMAL_REGEXP,
      :end_offset      => DECIMAL_REGEXP,
      :channel         => /\d{1,4}/,
      :sample_rate     => /\d{1,6}/
    }
  
  # for original audio
  match 'media/(:id)' => 'media#item',
    :constraints => { 
      :id              => /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/
    }
  
  # routes for authentication with devise
  #namespace :api do
  #  resources :tokens, :only => [:create, :destroy]
  #end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id))(.:format)'
end
