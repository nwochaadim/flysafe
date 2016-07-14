require "rails_helper"

RSpec.describe Flight, type: :model do
  let!(:flight) { create(:flight) }
  subject { flight }
  describe "Initializing Flight" do
    it "validates presence of plane_name" do
      expect(flight).to be_valid
    end
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:stops) }
    it { is_expected.to respond_to(:plane_name) }
    it { is_expected.to respond_to(:seats_available) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:route) }
  end

  describe "Active Model Relation" do
    it { is_expected.to respond_to(:bookings) }
  end
end
