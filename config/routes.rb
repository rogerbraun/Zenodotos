# -*- encoding : utf-8 -*-
Zenodotos::Application.routes.draw do

  match "admin" => "dashboard#index", :via => :get

  devise_for :admin_users, :path => "admin"

  get "home/index"

  match "/search" => 'search#index'
  match "/advanced_search" => 'search#advanced_search'
  match "/advanced_search/results" => 'search#advanced_search_results', :via => :get
  match '/search/:id' => 'search#show', :as => 'opac_show_book'
  
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

  namespace :admin do
    post "lendings/return_or_extend"
    match 'reservations/:id' => 'books#delete_reservation', :as => 'delete_reservation', :via => :delete
    match "/advanced_search" => 'advanced_search#index'
    match "/advanced_search/results" => 'advanced_search#show_results', :via => :get
    resources :collections do

      member do
        post 'remove_books'
        get "mass_edit"
        post "do_mass_edit"
        match "/books/:book_id/remove" => "collections#remove_book", :as => "remove_book", :via => :post
      end
    end
    resources :borrowers 
    resources :coworkers
    resources :books do
      collection do
        get "next_free_signature"
        get "add_all_to_collection"
        post "put_all_into_collection"
      end
      member do
        # TODO find a nicer way to do this
        get "add_to_collection"
        post "put_into_collection"
        get "duplicate"
        get "lendings/new", :action => "new_lending"
        post "lendings", :action => "create_lending"
        get 'reservations/new', action: 'new_reservation'
        post 'reservations', action: 'create_reservation'
        post "extend_current_lending"
        post "return_book"
      end

    end
    resources :printouts
    resources :reminders do
      collection do
        get "change_text"
        post "save_text"
      end
      member do
        post "deliver"
      end
    end
  end
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
  # match ':controller(/:action(/:id(.:format)))'
end
