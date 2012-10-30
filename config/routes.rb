QubarSite::Application.routes.draw do

  resources :audio_events

  resources :audio_recordings

  resources :projects, :sites, :photos, :users
  
  # audio and spectrogram media items
  # (?<id>[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})_(?<start_offset>\d{9})_(?<end_offset>\d{9})_(?<channel>\d{1,4})_(?<sample_rate>\d{1,6}).(?<format>\S{1,4})
  # audio: http://localhost:3000/media/21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_012345678_1024_100000.webma
  # image: http://localhost:3000/media/21EC2020-3AEA-1069-A2DD-08002B30309D_012345678_012345678_1024_100000_1024_g.png
  match 'media' => 'media#index'
  
  # for cached spectrograms
  match 'media/(:id)_(:start_offset)_(:end_offset)_(:channel)_(:sample_rate)_(:window)_(:colour)(:format)' => 'media#item', 
    :constraints => { 
      :id              => /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/,
      :start_offset    => /\d{1,9}/,
      :end_offset      => /\d{1,9}/,
      :channel         => /\d{1,4}/,
      :sample_rate     => /\d{1,6}/,
      :window          => /\d{1,4}/,
      :colour          => /[a-zA-Z]{1}/,
      :format          => /\.\S{1,5}/
    }
  
  # for cached audio
  match 'media/(:id)_(:start_offset)_(:end_offset)_(:channel)_(:sample_rate)(:format)' => 'media#item', 
    :constraints => { 
      :id              => /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/,
      :start_offset    => /\d{1,9}/,
      :end_offset      => /\d{1,9}/,
      :channel         => /\d{1,4}/,
      :sample_rate     => /\d{1,6}/,
      :format          => /\.\S{1,5}/
    }
  
  # for original audio
  match 'media/(:id)_(:date)_(:time)(:format)' => 'media#item', 
    :constraints => { 
      :id              => /[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}/,
      :date            => /\d{8}/,
      :time            => /\d{6}/,
      :format          => /\.\S{1,5}/
    }
  
  
  
  
  get "home/index"

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
  # match ':controller(/:action(/:id))(.:format)'
end
