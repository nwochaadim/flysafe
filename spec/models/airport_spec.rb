require "rails_helper"

RSpec.describe Airport, type: :model do

  describe "Active model validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:airport_code) }

    it { is_expected.to have_many(:departing_flights) }
    it { is_expected.to have_many(:arriving_flights) }
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:country) }
    it { is_expected.to respond_to(:state) }
    it { is_expected.to respond_to(:airport_code) }
    it { is_expected.to respond_to(:departing_flights) }
    it { is_expected.to respond_to(:arriving_flights) }
  end

  describe ".names" do
    it "lists all airport names along with codes" do
      airport = create(:airport, flights_count: 2) 

      expect(Airport.names).
        to include("#{airport.name} (#{airport.airport_code})")
    end
  end
end
