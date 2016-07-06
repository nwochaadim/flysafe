module BookingsHelper
  def calculate_flight_fare(booking_params)
    booking_params = booking_params.stringify_keys
    passengers = []
    booking_params['adult'].each { |adult| build_passengers(passengers, adult, 'Adult') }
    booking_params['child'].each { |child| build_passengers(passengers, child, 'Child') }
    booking_params['infant'].each { |infant| build_passengers(passengers, infant, 'Infant') }
    session[:total_cost] = estimate_flight_fare(passengers, booking_grade)
  end

  def build_passengers(passengers, params, type)
    params = params.merge(age_grade: type)
    passengers << Passenger.new(params)
  end

  def booking_grade
    session[:passengers]['class_level'].to_sym
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
    class_level = grade || booking_grade
    total_cost = adult_fares[class_level]
    passengers.each do |passenger|
      unless passenger.age_grade == 'Infant'
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
