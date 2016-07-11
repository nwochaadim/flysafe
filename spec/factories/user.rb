FactoryGirl.define do
  factory :user do
    first_name Faker::Name.name
    last_name Faker::Name.name
    email Faker::Internet.email
    phone Faker::PhoneNumber.phone_number
    password 'secret_key'
    password_confirmation 'secret_key'
  end
end
