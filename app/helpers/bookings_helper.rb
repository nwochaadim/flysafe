module BookingsHelper
  def calculate_flight_fare(booking_params)
    params = booking_params.stringify_keys
    passengers = []
    allowed_passengers = %w(adult child infant)
    iterate_passengers(passengers, params, allowed_passengers)
    session[:total_cost] = estimate_flight_fare(passengers, booking_grade)
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

  def estimate_flight_fare(passengers, grade = nil)
    class_level = grade.to_sym || booking_grade
    total_cost = adult_fares[class_level]
    passengers.each do |passenger|
      unless passenger.age_grade == "Infant"
        total_cost += adult_fares[class_level]
      end
    end
    total_cost
  end

  def iterate_passengers(passengers, params, allowed_passengers)
    allowed_passengers.each do |allowed_passenger|
      next unless params[allowed_passenger]
      params[allowed_passenger].each do |passenger|
        build_passengers(passengers, passenger, allowed_passenger.capitalize)
      end
    end
  end

  def build_passengers(passengers, params, type)
    params = params.merge(age_grade: type)
    passengers << Passenger.new(params)
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
      Business: 5000
    }
  end

  def infant_fares
    {
      Economy: 0,
      Business: 0
    }
  end
end
