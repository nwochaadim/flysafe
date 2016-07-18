class BookingsController < ApplicationController
  include Bookings
  before_action :set_booking, only: [:retrieve, :destroy, :update]
  protect_from_forgery except: [:retrieve, :destroy]

  def confirm
    session[:booking_params] = booking_params
    @booking_params = booking_params

    render format: :js
  end

  def book
    session[:flight_id] ||= params[:selected_flight]

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
    render format: :js
  end

  def search
  end

  def update
    @booking.update_passengers(booking_params)
    UserMailer.update_reservation(@booking.id).deliver_now if @booking.user
    redirect_to search_booking_path, notice: booking_success
  end

  def destroy
    UserMailer.delete_reservation(@booking.id).deliver_now if @booking.user
    @booking.destroy

    render json: { success: true }
  end

  private

  def set_booking
    @booking = Booking.find_by(reference_number: params[:reference_number])
  end

  def instantiate_payment_service
    selected_flight = Flight.find(session[:flight_id])

    PaymentService.new(
      selected_flight: selected_flight,
      validate_url: validate_payment_url(selected_flight),
      contact_url: contact_url,
      total_cost: session[:total_cost]
    )
  end

  def booking_params
    passenger_fields = %w(gender first_name last_name)
    params.permit(adult: passenger_fields, child: passenger_fields,
                  infant: passenger_fields)
  end
end
