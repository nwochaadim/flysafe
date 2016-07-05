require 'rails_helper'

RSpec.describe BookingsHelper, type: :helper do
  before(:each){ 
    session[:passengers] = {}
    session[:passengers]["class_level"] = "Economy" 
  }

  let(:booking_params){ 
    { first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      format: :js,
      email: Faker::Internet.email,
      "adult": [{gender: "1", "first_name": "John", "last_name": "Travolta"}],
      "child": [{"first_name": "Mercy", "last_name": "Johnson"}],
      "infant": [{"first_name": "Michelle", "last_name": "Obama"}] 
    }
  }

  describe "calculate flight fare" do
    it "returns the total flight fee" do
      flight_fare = calculate_flight_fare(booking_params)
      expect(flight_fare ).to eq(3000)
    end
  end


  describe "booking grade" do
    it "returns the class level saved in the session" do
      expect(booking_grade).to eq(:Economy)
    end
  end

  describe "adult fare" do
    it "returns the adult flight fee" do
      expect(adult_fare).to eq(1000)
    end
  end

  describe "child fare" do
    it "returns the child flight fee" do
      expect(child_fare).to eq(1000)
    end
  end

  describe "infant fare" do
    it "returns the child flight fee" do
      expect(infant_fare).to eq(0)
    end
  end

  describe "estimate flight fare" do
    it "returns the total flight fare for all passengers" do
      expect(infant_fare).to eq(0)
    end
  end


end
