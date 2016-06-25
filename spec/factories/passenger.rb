FactoryGirl.define do
  factory :adult_passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
    gender ["Male", "Female"].sample
    age_grade "Adult"
  end

  factory :child_passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
    gender ["Male", "Female"].sample
    age_grade "Child"
  end

  factory :infant_passenger do
    first_name Faker::Name.name
    last_name Faker::Name.name
    gender ["Male", "Female"].sample
    age_grade "Infant"
  end
end