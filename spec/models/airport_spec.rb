require "rails_helper"

RSpec.describe Airport, type: :model do

  describe "Active model validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:airport_code) }

    it { should have_many(:departing_flights) }
    it { should have_many(:arriving_flights) }
  end

  describe "Instance Methods" do
    it { should respond_to(:name) }
    it { should respond_to(:country) }
    it { should respond_to(:state) }
    it { should respond_to(:airport_code) }
    it { should respond_to(:departing_flights) }
    it { should respond_to(:arriving_flights) }
  end

  describe ".names" do
    it "lists all airport names along with codes" do
      airport = create(:airport, flights_count: 2) 

      expect(Airport.names).
        to include("#{airport.name} (#{airport.airport_code})")
    end
  end
end
