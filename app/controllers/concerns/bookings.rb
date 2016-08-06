module Bookings
  def create_booking(flight, reference)
    booking_params = session[:booking_params]
    class_level = session[:passengers]["class_level"]
    @booking = Booking.create_and_allocate(
      flight: flight,
      reference_number: reference,
      class_level: class_level,
      booking_params: booking_params,
      user: current_user
    )
    UserMailer.booking_success(@booking.id).deliver_now
  end
end
