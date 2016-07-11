FactoryGirl.define do
  factory :booking, aliases: [:economy_booking] do
    reference_number SecureRandom.hex(6)
    flight
    user
    class_level 'Economy'
  end
end
