module BookingsHelper
  def calculate_flight_fare(booking_params)
    no_of_adults = booking_params["adult"] ? booking_params["adult"].count + 1 : 1
    no_of_children = booking_params["child"] ? booking_params["child"].count : 0
    no_of_infants = booking_params["child"] ? booking_params["infant"].count  : 0
    total_cost = no_of_adults * (AdultPassenger::ECONOMY_FLIGHT_FARE) + 
                  no_of_children * (ChildPassenger::ECONOMY_FLIGHT_FARE) +
                  no_of_infants * (InfantPassenger::ECONOMY_FLIGHT_FARE)
  end

  def adult_fare
    "$#{AdultPassenger::ECONOMY_FLIGHT_FARE}"
  end

  def child_fare
    "$#{ChildPassenger::ECONOMY_FLIGHT_FARE}"
  end

  def infant_fare
    "$#{InfantPassenger::ECONOMY_FLIGHT_FARE}"
  end

end
