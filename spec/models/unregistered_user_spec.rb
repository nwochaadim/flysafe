require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:unregistered_user) }

  describe "Initializing UnregisteredUser" do
    let(:unregistered_user1) { build(:unregistered_user, first_name: nil) }
    let(:unregistered_user2) { build(:unregistered_user, last_name: nil) }
    let(:unregistered_user3) { build(:unregistered_user, email: nil) }

    it "validates presence of first_name" do
      expect(unregistered_user1).to be_invalid
    end

    it "validates presence of last_name" do
      expect(unregistered_user2).to be_invalid
    end

    it "validates presence of email" do
      expect(unregistered_user3).to be_invalid
    end
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:email) }
  end

  describe "Active Model Relation" do
    it { is_expected.to respond_to(:bookings) }
  end
end
