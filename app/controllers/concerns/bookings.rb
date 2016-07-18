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
    UserMailer.booking_success(@booking.id).deliver_now if @booking.user
  end

  def retrieve_passengers_from_session
    passengers = session[:passengers].stringify_keys
    no_of_children = passengers["total_children"]
    no_of_adults = passengers["total_adults"]
    no_of_infants = passengers["total_infants"]
    no_of_children + no_of_adults + no_of_infants
  end
end
