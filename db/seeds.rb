require "json"
require "faker"

Airport.destroy_all
Route.destroy_all



aircrafts = %w(Airbus\ A300
  Airbus\ A318
  Baade\ 152
  Boeing\ 707
  Boeing\ 717
  Boeing\ 737
  Comac\ C919
  Convair\ 880
  McDonnell\ Douglas\ MD-90
)

def create?(data)
  country_name = data["country"].to_sym
  allowed_country = allowed_countries[country_name]
end

def create_airport(data, index)
  DepartingAirport.create(
    name: data["name"],
    country: data["country"],
    state: data["state"],
    airport_code: data["code"])
end

def allowed_countries
  { "Nigeria": true }
end

def retrieve_arriving_airport(state)
  airport_length = DepartingAirport.all.count
  arriving_airport = nil
  loop do
    index = rand(1..airport_length)
    arriving_airport = DepartingAirport.find(index).attributes
    break unless arriving_airport[:state] == state
  end
  arriving_airport
end



def create_routes
  DepartingAirport.all.each do |departing_airport|
    terminating_index = rand(20..50)
    arriving_airports = []
    (1..terminating_index).each do
      route = departing_airport.routes.create
      arriving_airport = retrieve_arriving_airport(departing_airport.state)
      route.create_arriving_airport(arriving_airport)
    end
  end
end

def create_airports_from_file
  jsonFile = File.read(Rails.root.to_s+"/app/assets/airports.json")
  jsonData = JSON.parse(jsonFile)
  jsonData.each_with_index do |data, index|
    if create?(data)
      create_airport(data, index)   
    end
  end
end
create_airports_from_file
create_routes

Route.all.each do |route|
  flight_date = Faker::Date.between_except(1.days.from_now, 1.month.from_now, Date.today)
  plane_name = aircrafts[rand(9)]
  seats_available = rand(100..150)
  route.create_flight(stops: 1, plane_name: plane_name, seats_available: seats_available, date: flight_date)
end




