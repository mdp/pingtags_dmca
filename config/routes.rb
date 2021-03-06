ActionController::Routing::Routes.draw do |map|
  map.connect 'authenticate', :controller => 'user_sessions', :action => 'new'
  map.resources :users
  map.resources :scans, :member => {:update_location => :get}
  map.resource :account, :member => {:update_contact => :get}
  map.resources :user_sessions, :collection => {:linkedin => :get}
  
  map.namespace(:admin) do |admin|
    admin.resources :users
  end

  map.oauth_callback '/oauth_callback', :controller => 'user_sessions', :action => 'oauth_callback'
  
  map.link '/l', :controller => 'links', :action => 'create'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.signup '/signup', :controller => 'users', :action => 'create'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.tag '/:crypt_id', :controller => 'users', :action => 'show'
  
  # Redirection for links to track clicks

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.root :controller => 'home', :action => 'index'
  map.profile '/:crypt_id', :controller => 'users', :action => 'show'

end
