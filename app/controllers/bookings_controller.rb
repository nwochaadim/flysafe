class BookingsController < ApplicationController
  include Bookings
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
    payment_service = instantiate_payment_service
    response = payment_service.make_payment
    session[:token] = response.token
    redirect_to response.redirect_uri
  end

  def validate_payment
    if params[:token] == session[:token]
      selected_flight = Flight.find(session[:flight_id])
      create_booking(selected_flight, params[:token])
    else
      flash[:notice] = invalid_payment
    end
  end

  def retrieve
    @reference_number = params[:reference_number]
    bookings = Booking.where(reference_number: @reference_number)
    @booking = if bookings.empty?
                 nil
               else
                 bookings.first
               end
    render format: :js
  end

  def search
  end

  def update
    @booking = Booking.find(params[:id])
    user = @booking.user || @booking.unregistered_user
    user.update(
                first_name: booking_params[:first_name],
                last_name: booking_params[:last_name],
                email: booking_params[:email]
                )
    @booking.passengers.destroy_all
    @booking.add_passengers(booking_params)
    UserMailer.update_reservation(user, @booking.id).deliver_now
    redirect_to search_booking_path, notice: booking_success
  end

  def destroy
    bookings = Booking.where(reference_number: params[:id])
    @booking = bookings.first unless bookings.empty?
    @user = @booking.user || @booking.unregistered_user
    UserMailer.delete_reservation(@user, @booking.id).deliver_now
    @booking.destroy
    render json: { success: true }
  end

  private

  def instantiate_payment_service
    selected_flight = Flight.find(session[:flight_id])
    validate_url = validate_payment_url(selected_flight)
    PaymentService.new(selected_flight, validate_url, contact_url)
  end

  def booking_params
    passenger_fields = %w(gender first_name last_name)
    params.permit(:first_name, :last_name, :email, adult: passenger_fields, child: passenger_fields, infant: passenger_fields)
  end
end
