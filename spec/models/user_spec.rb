require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe "Initializing User" do
    let(:user1) { build(:user, first_name: nil) }
    let(:user2) { build(:user, last_name: nil) }
    let(:user3) { build(:user, email: nil) }

    it "validates presence of first_name" do
      expect(user1).to be_invalid
    end

    it "validates presence of last_name" do
      expect(user2).to be_invalid
    end

    it "validates presence of email" do
      expect(user3).to be_invalid
    end
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:phone) }
  end

  describe "Active Model Relation" do
    it { is_expected.to respond_to(:bookings) }
  end
end
