FactoryGirl.define do
  factory :airport do
    name "Murtala Mohammed Airport"
    country Faker::Address.country
    state Faker::Address.state
    airport_code Faker::Address.country_code
  end
end