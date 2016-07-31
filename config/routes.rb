Rails.application.routes.draw do
  root 'landing#index'

  scope controller: :landing do
    get "/about" => :about, as: :about
    get "/contact" => :contact_us, as: :contact
    post "/feedback" => :create_feedback, as: :feedback
  end

  scope controller: :session do
    get "/login" => :new, as: :login
    get "/logout" => :destroy, as: :logout
    post "/session" => :create, as: :session
  end

  scope "/users", controller: :users do
    get "/signup" => :new, as: :signup
    get "/bookings" => :past_bookings, as: :past_bookings
    post "/" => :create
  end

  scope "/flights", controller: :flights do
    post "/search" => :search, as: :search_flights
    get "/seats_available" => :seats_available
  end

  scope "/bookings", controller: :bookings do
    post "/book" => :book, as: :book
    get "/search" => :search, as: :search_booking
    post "/" => :retrieve, as: :retrieve_booking
    get "/payment" => :payment, as: :payment
    post "/confirm" => :confirm, as: :confirm_book
    put "/:reference_number" => :update
    delete "/:reference_number" => :destroy
    get "/payment/:flight_id" => :validate_payment, as: :validate_payment
  end
end
