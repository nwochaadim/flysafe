FactoryGirl.define do
  factory :airport do
    sequence(:name) { |n| "Murtala Mohammed Airport#{n}" }
    country Faker::Address.country
    state Faker::Address.state
    airport_code "ANC"

    transient do
      flights_count 0
    end

    after(:create) do |airport, evaluator|
      count = evaluator.flights_count
      depart_flights = create_list(:flight, count, :departing, airport: airport)
      arrive_flights = create_list(:flight, count, :arriving, airport: airport)
      airport.update(arriving_flights: arrive_flights)
      airport.update(departing_flights: depart_flights)
    end
  end
end
