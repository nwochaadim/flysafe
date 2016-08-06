require "rails_helper"

RSpec.describe Flight, type: :model do

  describe "ActiveRecord Associations" do
    it { is_expected.to have_many(:bookings) }
    it { is_expected.to belong_to(:from_airport) }
    it { is_expected.to belong_to(:to_airport) }
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:stops) }
    it { is_expected.to respond_to(:plane_name) }
    it { is_expected.to respond_to(:seats_available) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:from_airport) }
    it { is_expected.to respond_to(:to_airport) }
  end
end
