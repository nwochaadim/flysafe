Rails.application.routes.draw do


  root 'landing#index'

  get "/about" => "landing#about", as: :about

  get "/contact" => "landing#contact_us", as: :contact



  get "/login" => "session#new", as: :login

  get "/logout" => "session#destroy", as: :logout

  post "/session" => "session#create", as: :session


  get "/signup" => "users#new", as: :signup
  get "/users/:user_id/bookings" => "users#past_bookings", as: :past_bookings

  
  
  get "/flights/search" => "flights#search", as: :search_flights


  post "/book" => "bookings#book", as: :book

  get "/bookings/search" => "bookings#search", as: :search_booking

  post "/bookings" => "bookings#retrieve", as: :retrieve_booking

  get "/payment" => "bookings#payment", as: :payment

  post "/confirm" => "bookings#confirm", as: :confirm_book
  
  get "/payment/:flight_id" => "bookings#validate_payment", as: :validate_payment
  
  
  resources :passengers
  resources :bookings
  resources :users
  resources :flights
  resources :routes
  resources :airports
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
