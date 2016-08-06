require "rails_helper"

RSpec.describe Booking, type: :model do
  let(:flight) { create(:flight) }
  let(:booking) { create(:economy_booking) }
  let(:adult_passenger) { create(:adult_passenger) }
  let(:child_passenger) { create(:child_passenger) }
  let(:infant_passenger) { create(:infant_passenger) }
  let(:passengers_param) do
    { adult: [{ first_name: "George", last_name: "James" }] }.stringify_keys
  end

  describe "ActiveRecord Validation" do
    it { is_expected.to validate_presence_of(:reference_number) }
    it { is_expected.to validate_presence_of(:class_level) }
  end

  describe "ActivRecord Relationships" do
    it { is_expected.to belong_to(:flight) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:passengers) }
  end

  describe "#allocate_flight" do
    it "reduces the seats_available on the flight by number of passengers" do
      booking.passengers << adult_passenger
      booking.passengers << child_passenger

      expect { booking.allocate_flight(flight) }.
        to change { flight.seats_available }.by(-2)
    end

    it "does not allocate seats for infants" do
      booking.passengers << adult_passenger
      booking.passengers << infant_passenger

      expect { booking.allocate_flight(flight) }.
        to change { flight.seats_available }.by(-1)
    end
  end

  describe "#add_passengers" do
    it "reserves the passenger" do
      expect { booking.add_passengers(passengers_param) }.
        to change { booking.passengers.count }.by(1)
    end
  end

  describe "#update_passengers" do
    it "updates the passengers info for the flight" do
      booking.update_passengers(passengers_param)
      expect(booking.passengers.first.first_name).to eql("George")
    end
  end
end
