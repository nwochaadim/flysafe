require "json"
require "faker"

Airport.destroy_all
Flight.destroy_all

def aircrafts
  %w(
    Airbus\ A300
    Airbus\ A318
    Baade\ 152
    Boeing\ 707
    Boeing\ 717
    Boeing\ 737
    Comac\ C919
    Convair\ 880
    McDonnell\ Douglas\ MD-90
  )
end

def create?(data)
  country_name = data["country"].to_sym
  allowed_country = allowed_countries[country_name]
end

def create_airport(data)
  Airport.create(
    name: data["name"],
    country: data["country"],
    state: data["state"],
    airport_code: data["code"]
  )
end

def allowed_countries
  { Nigeria: true }
end

def create_airports_from_file
  json_file = File.read(Rails.root.to_s + "/app/assets/airports.json")
  json_data = JSON.parse(json_file)
  json_data.each do |data, _index|
    if create?(data)
      create_airport(data)
    end
  end
end

def get_arriving_airport(holder)
  airport = Airport.find(rand(1..14))
  loop do
    airport = Airport.find(rand(1..14))
    break unless holder.include?(airport)
  end
  airport
end

def create_flights_from_airports
  Airport.all.each do |airport|
    arriving_airport_holder = []
    arriving_airport_holder << airport
    iteration_length = rand(10..13)
    iteration_length.times do
      arriving_airport = get_arriving_airport(arriving_airport_holder)
      arriving_airport_holder << arriving_airport
      create_flights(airport, arriving_airport)
    end
  end
end

def create_flights(airport, arriving_airport)
  seats_available = rand(103..110)
  iteration_length = rand(3..5)
  iteration_length.times do
    date = Faker::Date.forward(23)
    plane_name = aircrafts[rand(0..8)]
    Flight.create(
      stops: 1,
      plane_name: plane_name,
      seats_available: seats_available,
      date: date,
      to_airport_id: arriving_airport.id,
      from_airport_id: airport.id
    )
  end
end

create_airports_from_file
create_flights_from_airports
