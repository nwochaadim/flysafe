require "rails_helper"

RSpec.describe Flight, type: :model do

  describe "ActiveRecord Associations" do
    it { should have_many(:bookings) }
    it { should belong_to(:from_airport) }
    it { should belong_to(:to_airport) }
  end

  describe "Instance Methods" do
    it { should respond_to(:stops) }
    it { should respond_to(:plane_name) }
    it { should respond_to(:seats_available) }
    it { should respond_to(:date) }
    it { should respond_to(:from_airport) }
    it { should respond_to(:to_airport) }
  end
end
