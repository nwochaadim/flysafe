FactoryGirl.define do
  factory :unregistered_user do
    first_name Faker::Name.name
    last_name Faker::Name.name
    email Faker::Internet.email
  end
end
