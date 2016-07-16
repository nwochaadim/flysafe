class BookingsController < ApplicationController
  include Bookings
  attr_accessor :token
  protect_from_forgery except: [:retrieve, :destroy]

  def confirm
    session[:booking_params] = params
    @booking_params = params
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
    reference_number = params[:reference_number]
    @booking = Booking.find_by(reference_number: reference_number)
    render format: :js
  end

  def search
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update_passengers(params)
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
    total_cost = session[:total_cost]
    PaymentService.new(selected_flight, validate_url, contact_url, total_cost)
  end
end
