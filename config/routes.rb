# -*- encoding : utf-8 -*-
Zenodotos::Application.routes.draw do

  get "fm_style/index"

  match "admin" => "dashboard#index", :via => :get
  match "admin/books" => "books#index", :via => :get, :as => "admin_books"
  match "admin/books/:id/edit" => "books#edit", :via => :get, :as => "edit_admin_book"
  match "admin/books/new" => "books#new", :via => :get, :as => "new_admin_book"
  match "admin/books/:dup_id/duplicate" => "books#new", :via => :get, :as => "duplicate_admin_book"
  match "admin/books/:id/lending/new" => "books#new_lending", :via => :get, :as => "new_book_lending"
  match "admin/books/:id/lending" => "books#create_lending", :via => :post, :as => "create_book_lending"

  match "admin/books/:id" => "books#show", :via => :get, :as => "admin_book"
  match "admin/books/:id/return" => "books#return_current_lending", :via => :post, :as => "return_current_lending"
  match "admin/books/:id/extend" => "books#extend_current_lending", :via => :post, :as => "extend_current_lending"

  match "admin/lendings" => "lendings#index", :via => :get, :as => "admin_lendings"
  match "admin/lending/:id" => "lendings#show", :via => :get, :as => "admin_lending"

  devise_for :admin_users, :path => "admin"

  get "home/index"

  match "/search" => 'search#index'
  
  resources :printouts

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
    resources :borrowers
    resources :reminders do
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
  root :to => 'search#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
