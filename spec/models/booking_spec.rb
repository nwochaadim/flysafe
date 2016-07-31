require "rails_helper"

RSpec.describe Booking, type: :model do
  let(:flight) { create(:flight) }
  let!(:booking) { create(:economy_booking) }
  let!(:adult_passenger) { create(:adult_passenger) }
  let(:child_passenger) { create(:child_passenger) }
  let(:infant_passenger) { create(:infant_passenger) }
  let(:passengers_param) do
    { adult: [{ first_name: "George", last_name: "James" }] }.stringify_keys
  end

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
