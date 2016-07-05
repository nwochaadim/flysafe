class BookingsController < ApplicationController  
  attr_accessor :token
  protect_from_forgery except: [:retrieve, :destroy]

  def confirm
    session[:booking_params] = booking_params
    @booking_params = booking_params
    render format: :js
  end

  def book
    session[:flight_id] ||= params[:selected_flight]
    retrieve_passengers_from_session
    render format: :js
  end

  def payment
    selected_flight = Flight.find(session[:flight_id])
    request = Paypal::Express::Request.new(paypal_request_params)
    payment_request = Paypal::Payment::Request.new(payment_request_params)
    response = request_paypal_payment(request, payment_request, selected_flight)
    session[:token] = response.token
    @paypal_uri = response.redirect_uri
    redirect_to @paypal_uri
  end

  def validate_payment
    if params[:token] == session[:token]
      selected_flight = Flight.find(session[:flight_id])
      create_booking(selected_flight)
    end
  end

  def retrieve
    @reference_number = params[:reference_number]
    bookings = Booking.where(reference_number: @reference_number)
    if bookings.empty?
      @booking = nil
    else
      @booking = bookings.first
    end
    render format: :js
  end

  
  # def edit
  # end

  def search
  end


  def update
    @booking = Booking.find(params[:id])
    user = @booking.user || @booking.unregistered_user
    user.update(first_name: booking_params[:first_name], 
      last_name: booking_params[:last_name], 
      email: booking_params[:email] )
    @booking.passengers.destroy_all
    @booking.addPassengers(booking_params)
    UserMailer.update_reservation(user.id, @booking.id).deliver_now
    redirect_to search_booking_path, notice: 'Booking was successfully updated.'
  end

  def destroy
    bookings = Booking.where(reference_number: params[:id])
    unless bookings.empty?
      @booking = bookings.first
    end
    @user = @booking.user || @booking.unregistered_user
    UserMailer.delete_reservation(@user.id, @booking.id).deliver_now
    @booking.destroy
    render json: {head: no_content}
  end

  private
  
  def generate_token
    loop do
      @token = SecureRandom::hex(6)
      bookings = Booking.where(reference_number: @token)
      break if bookings.empty?
    end
    @token
  end

  def paypal_options 
    {
      no_shipping: true, 
      allow_note: false,
      pay_on_paypal: true
    }
  end

  def paypal_request_params
    {
      username: "nwocha.adim-facilitator_api1.gmail.com",
      password: "65KMEBVFE3V5MQVF",
      signature: "AiPC9BjkCyDFQXbSkoZcgqH3hpacAWHLrfN1pZw2YLyitsE1A89vwHDf"
    }
  end

  def payment_request_params
    {
      description: "Book Your Flight while you are alive",
      quantity: 1,
      amount: session[:total_cost],
      custom_fields: {
        CARTBORDERCOLOR: "C00000",
        LOGOIMG: "http://clipartbest.com//cliparts/McL/oaR/McLoaRqca.svg"
      }
    }
  end

  def request_paypal_payment(request, payment_request, selected_flight)
    request.setup(
      payment_request,
      validate_payment_url(selected_flight),
      contact_url,
      paypal_options
    ) 
  end

  def create_booking(flight)
    retrieved_booking_params = session[:booking_params].stringify_keys
    user = current_user || create_unregistered_user(retrieved_booking_params)
    class_level = session[:passengers]["class_level"]
    @booking = user.bookings.create(reference_number: generate_token, class_level: class_level)
    @booking.addPassengers(retrieved_booking_params)
    @booking.allocate_flight(flight)
  end

  def create_unregistered_user(retrieved_booking_params)
    UnregisteredUser.create(
      first_name: retrieved_booking_params["first_name"],
      last_name: retrieved_booking_params["last_name"],
      email: retrieved_booking_params["email"]
    )
  end

  def retrieve_passengers_from_session
    session[:passengers] = session[:passengers].stringify_keys
    @no_of_children = session[:passengers]["total_adults"]
    @no_of_adults = session[:passengers]["total_infants"]
    @no_of_infants = session[:passengers]["total_children"]
    @no_of_children + @no_of_adults + @no_of_infants
  end

  def booking_params
    passenger_fields = ["gender", "first_name", "last_name"]
    param = params.permit(:first_name, :last_name, :email, adult: passenger_fields, child: passenger_fields, infant: passenger_fields)
  end
end
