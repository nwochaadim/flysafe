require "rails_helper"

RSpec.describe Passenger, type: :model do
  let(:passenger) { create(:adult_passenger) }

  describe "ActiveRecord Validations" do
    it{ should validate_presence_of(:first_name) }
    it{ should validate_presence_of(:last_name) }
    it{ should belong_to(:booking) }
  end

  describe "Instance Methods" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:age_grade) }
    it { should respond_to(:email) }
  end

  describe ".not_infant" do
    it "returns all passengers that are not infants" do
      expect(Passenger.not_infant).to include(passenger)
    end
  end
end
