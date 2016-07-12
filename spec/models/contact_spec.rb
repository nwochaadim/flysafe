require "rails_helper"

RSpec.describe Contact, type: :model do
  let(:contact) { create(:contact) }
  subject { contact }

  describe "Initializing Contact" do
    it "validates presence of plane_name" do
      expect(contact).to be_valid
    end
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:phone_number) }
    it { is_expected.to respond_to(:comment) }
  end
end
