SecretrevApi::Application.routes.draw do

  resources :challenges, except: :edit

  resources :challenges


  namespace :v1 do
    #TODO: implement alert/warning/error system for user-agents accessing old verisons, etc.
    resources :categorizations, except: :edit
    match 'categorizations' => 'categorizations#create', :constraints => {:method => 'OPTIONS'}
    resources :users, except: :edit
    match 'users' => 'users#create', :constraints => {:method => 'OPTIONS'}

    resources :categories, except: :edit

    get 'mods/total' => 'mods#total'
    get 'mods/name/:q' => 'mods#name', :q => /.*/
    get 'mods/version/:q' => 'mods#version', :q => /.*/
    get 'mods/author/:q' => 'mods#author', :q => /.*/
    get 'mods/count/:count(/offset/:offset)' => 'mods#count', :count => /\d+/, :offset => /\d+/
    get 'mods/uncategorized(/:count)' => 'mods#uncategorized', :count => /\d+/
    match 'mods/uncategorized(/:count)' => 'mods#uncategorized', :constraints => {:method => 'OPTIONS'}
    get 'mods/incomplete(/:count)' => 'mods#incomplete', :count => /\d+/
    match 'mods/:id/break' => 'mods#break', :id => /\d+/, :constraints => {:method => 'OPTIONS'}
    post 'mods/:id/break' => 'mods#break', :id => /\d+/
    get 'mods/available/:user_id' => 'mods#available?', :user_id => /\d+/

    resources :mods, except: :edit
    get 'challenge' => 'challenge#random'
    post 'challenge' => 'challenge#check'

    get 'categories' => 'categories#index'
  end

  root :to => 'mods#index'


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
