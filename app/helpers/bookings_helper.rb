module BookingsHelper
  def calculate_flight_fare(booking_params)
    passengers = []
    allowed_passengers = %w(adult child infant)
    iterate_passengers(passengers, booking_params, allowed_passengers)
    session[:total_cost] = estimate_flight_fare(passengers, booking_grade)
  end

  def booking_grade
    session[:passengers]["class_level"].to_sym
  end

  def adult_fare
    fares[booking_grade]
  end

  def child_fare
    fares[booking_grade]
  end

  def infant_fare
    0
  end

  def estimate_flight_fare(passengers, grade = nil)
    class_level = grade.to_sym || booking_grade
    total_cost = 0
    passengers.each do |passenger|
      unless passenger.age_grade == "Infant"
        total_cost += fares[class_level]
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

  def fares
    {
      Economy: 1000,
      Business: 5000
    }
  end
end
