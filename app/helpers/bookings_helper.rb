module BookingsHelper
  def calculate_flight_fare(booking_params)   
    no_of_adults = booking_params["adult"] ? booking_params["adult"].count + 1 : 1
    no_of_children = booking_params["child"] ? booking_params["child"].count : 0
    no_of_infants = booking_params["infant"] ? booking_params["infant"].count  : 0
    session[:total_cost] = no_of_adults * (adult_fares[booking_grade]) + 
                  no_of_children * (child_fares[booking_grade]) +
                  no_of_infants * (infant_fares[booking_grade])
  end

  def booking_grade
    session[:passengers]["class_level"].to_sym
  end

  def adult_fare
    adult_fares[booking_grade]
  end

  def child_fare
    child_fares[booking_grade]
  end

  def infant_fare
    infant_fares[booking_grade]
  end

  def estimate_flight_fare(passengers, grade=nil)
    class_level = grade || booking_grade
    total_cost = adult_fares[class_level]
    passengers.each do |passenger|
      unless passenger.age_grade == "Infant"
        total_cost += adult_fares[class_level]
      end
    end
    total_cost
  end

  def adult_fares
    {
      Economy: 1000,
      Business: 5000
    }
  end

  def child_fares
    {
      Economy: 1000,
      Business: 4000
    }
  end

  def infant_fares
    {
      Economy: 0,
      Business: 0
    }
  end

end
