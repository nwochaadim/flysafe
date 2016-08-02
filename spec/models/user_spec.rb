require "rails_helper"

RSpec.describe User, type: :model do
  subject{ create(:user) }

  describe "ActiveRecord Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }
  end

  describe "ActiveRecord Relationships" do
    it { should have_many(:bookings) }
  end

  describe "Instance Methods" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:phone) }
  end
end
