require "rails_helper"

RSpec.describe Booking, type: :model do
  let(:flight) { create(:flight) }
  let!(:booking) { create(:economy_booking) }
  let!(:adult_passenger) { create(:adult_passenger) }
  let(:child_passenger) { create(:child_passenger) }
  let(:infant_passenger) { create(:infant_passenger) }
  describe "Initializing a booking" do
    it "validates presence of a reference number" do
      expect { booking.update!(reference_number: nil) }.
        to raise_error(ActiveRecord::RecordInvalid)
    end

    it "validates presence of a class_level" do
      expect { booking.update!(class_level: nil) }.
        to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "Instance Methods" do
    subject { booking }
    it { is_expected.to respond_to(:reference_number) }
    it { is_expected.to respond_to(:class_level) }
  end

  describe "ActiveModel Relationships" do
    subject { booking }
    it { is_expected.to respond_to(:flight) }
    it { is_expected.to respond_to(:user) }
    it { is_expected.to respond_to(:unregistered_user) }
  end

  describe "Booking a flight" do
    it "reduces the seats_available on the flight by the number of passengers" do
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

  describe "Adding Passengers to a Booking" do
    it "reserves the passenger" do
      passenger = { adult: [{ first_name: "George", last_name: "James" }] }
      expect { booking.add_passengers(passenger) }.
        to change { booking.passengers.count }.by(0)
    end
  end
end
