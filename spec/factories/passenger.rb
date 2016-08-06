FactoryGirl.define do
  factory :passenger, class: Passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
  end

  factory :adult_passenger, parent: :passenger do
    age_grade "Adult"
  end

  factory :child_passenger, parent: :passenger do
    age_grade "Child"
  end

  factory :infant_passenger, parent: :passenger do
    age_grade "Infant"
  end
end
