FactoryGirl.define do
  factory :adult_passenger, class: Passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
    gender %w(Male Female).sample
    age_grade "Adult"
  end

  factory :child_passenger, class: Passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
    gender %w(Male Female).sample
    age_grade "Child"
  end

  factory :infant_passenger, class: Passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
    gender %w(Male Female).sample
    age_grade "Infant"
  end
end
