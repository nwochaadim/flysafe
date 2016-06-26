FactoryGirl.define do
  factory :flight do
    stops 0
    plane_name "Boeing 737"
    seats_available 10
    date Faker::Date.between_except(1.days.from_now, 1.month.from_now, Date.today)
    route
  end
end