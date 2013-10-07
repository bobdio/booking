Reservation::Application.routes.draw do

  devise_for :users
  resources :users , only: [:index, :show] do
    resources :bookings 
  end
  resources :relationships #, only: [:new, :create, :show]
  post '/users/:user_id/bookings/new', to: "bookings#new"
  put '/users/:user_id/bookings.:id', to: "bookings#update"
  delete '/users/:user_id/bookings.:id', to: "bookings#destroy"
  
  get 'relationships_confirm_client/:id', to: 'relationships#confirm_client'
  get 'relationships_block_client/:id', to: 'relationships#block_client'
  #get 'clients/', to: 'relationships#clients'
  #get 'employees/', to: 'relationships#employees'
  #get 'allusers/', to: 'relationships#index'
  get 'relations/', to: 'relationships#index'


  root :to => 'users#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
