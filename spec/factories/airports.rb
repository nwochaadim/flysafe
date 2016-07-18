FactoryGirl.define do
  factory :airport do
    name "Murtala Mohammed Airport"
    country Faker::Address.country
    state Faker::Address.state
    airport_code Faker::Address.country_code
  end

  factory :departing_airport, class: DepartingAirport, parent: :airport do
    name "Benin Airport"
    airport_code "BNI"
  end

  factory :arriving_airport, class: ArrivingAirport, parent: :airport do
    name "Lagos Murtala Muhammed Airport"
    airport_code "LOS"
    route
  end
end
