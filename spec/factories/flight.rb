FactoryGirl.define do
  factory :flight do
    stops 0
    plane_name "Boeing 737"
    seats_available 10
    date Faker::Date.forward(23)

    transient do
      airport { create(:airport) }
      arriving_airport { create(:airport) }
    end

    trait :departing do
      after(:create) do |flight, evaluator|
        flight.update(from_airport: evaluator.airport)
      end
    end

    trait :arriving do
      after(:create) do |flight, evaluator|
        flight.update(to_airport: evaluator.arriving_airport)
      end
    end
  end
end
