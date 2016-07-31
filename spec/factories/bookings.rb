FactoryGirl.define do
  factory :booking, aliases: [:economy_booking] do
    sequence(:reference_number) { |n| "REF#{n}" }
    flight { create(:flight, :arriving, :departing) }
    user
    class_level "Economy"
  end
end
