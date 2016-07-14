FactoryGirl.define do
  factory :airport do
    name "Murtala Mohammed Airport"
    country Faker::Address.country
    state Faker::Address.state
    airport_code Faker::Address.country_code
  end

  factory :departing_airport, aliases: [:departs] do
    name "Benin Airport"
    country "Nigeria"
    state "Benin"
    airport_code "BNI"
  end

  factory :arriving_airport, aliases: [:arrives] do
    name "Lagos Murtala Muhammed Airport"
    country "Nigeria"
    state "Lagos"
    airport_code "LOS"
    route
  end
end
