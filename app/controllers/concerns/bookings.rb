module Bookings
  def create_booking(flight, reference)
    retrieved_booking_params = session[:booking_params].stringify_keys
    user = current_user || create_unregistered_user(retrieved_booking_params)
    class_level = session[:passengers]["class_level"]
    @booking = user.bookings.create(reference_number: reference, class_level: class_level)
    @booking.add_passengers(retrieved_booking_params)
    @booking.allocate_flight(flight)
    UserMailer.booking_success(@booking).deliver_now
  end

  def create_unregistered_user(retrieved_booking_params)
    UnregisteredUser.create(
      first_name: retrieved_booking_params["first_name"],
      last_name: retrieved_booking_params["last_name"],
      email: retrieved_booking_params["email"]
    )
  end

  def retrieve_passengers_from_session
    passengers = session[:passengers].stringify_keys
    @no_of_children = passengers["total_children"]
    @no_of_adults = passengers["total_adults"]
    @no_of_infants = passengers["total_infants"]
    @no_of_children + @no_of_adults + @no_of_infants
  end
end
