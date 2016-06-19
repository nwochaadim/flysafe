require "json"
require "faker"

Airport.destroy_all
Route.destroy_all

def create?(data)
  country_name = data["country"].to_sym
  allowed_country = allowed_countries[country_name]
end

def create_airport(data, index)
  DepartingAirport.create(name: data["name"], country: data["country"], state: data["state"], airport_code: data["code"])
end

def allowed_countries
  { "Nigeria": true }
end

def retrieve_arriving_airport(state)
  airport_length = DepartingAirport.all.count
  arriving_airport = nil
  loop do
    index = Faker::Number.between(1, airport_length)
    arriving_airport = DepartingAirport.find(index).attributes
    break unless arriving_airport[:state] == state
  end
  arriving_airport
end



def create_routes
  DepartingAirport.all.each do |departing_airport|

    terminating_index = Faker::Number.between(2, 5)
    arriving_airports = []
    (1..terminating_index).each do
      flight_date = Faker::Date.between_except(1.days.from_now, 1.month.from_now, Date.today)
      route = departing_airport.routes.create( date: flight_date )
      

      loop do
        arriving_airport = retrieve_arriving_airport(departing_airport.state)
        if arriving_airports.include?(arriving_airport)
          next
        else
          arriving_airports << arriving_airport
          route.create_arriving_airport(arriving_airport)
          break
        end
      end

    end
  end
end


jsonFile = File.read(Rails.root.to_s+"/public/airports.json")

jsonData = JSON.parse(jsonFile)

jsonData.each_with_index do |data, index|
  if create?(data)
    create_airport(data, index)   
  end
end
create_routes

