require "rails_helper"

RSpec.describe Contact, type: :model do

  describe "ActiveRecord Validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:comment) }
  end

  describe "Instance Methods" do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:phone_number) }
    it { is_expected.to respond_to(:comment) }
  end
end
