FactoryGirl.define do
  factory :airport do
    name "Murtala Mohammed Airport"
    country Faker::Address.country
    state Faker::Address.state
    airport_code Faker::Address.country_code
  end

  factory :departing_airport, aliases: [:departs] do
    name "Murtala Mohammed Airport"
    country Faker::Address.country
    state Faker::Address.state
    airport_code Faker::Address.country_code
  end

  factory :arrving_airport do
    name "Murtala Mohammed Airport"
    country Faker::Address.country
    state Faker::Address.state
    airport_code Faker::Address.country_code
  end
end