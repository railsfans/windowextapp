Extapp::Application.routes.draw do
	match "girls/girl_add"=>"girls#girl_add"
	match "girls/girl_edit"=>"girls#girl_edit"
	match "girls/girl_delete"=>"girls#girl_delete"
	match "girls/girl_search"=>"girls#girl_search"
	match "upload/uploadin"=>"upload#uploadin"
	match "upload/uploadout"=>"upload#uploadout"
	match "upload/upload"=>"upload#upload"
	match "boys/add_tree"=>"boys#add_tree"
	match "boys/delete_tree"=>"boys#delete_tree"
	match "boys/edit_tree"=>"boys#edit_tree"
	match "boys/all_delete"=>"boys#all_delete"
	match "code/ajax"=>"code#ajax"
	match "code/list"=>"code#list"
  resources :girls
 
  post "girls/try"=>'girls#try'
  get "users/new"
  
  resources :boys


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
   match ':controller(/:action(/:id))(.:format)'
end
