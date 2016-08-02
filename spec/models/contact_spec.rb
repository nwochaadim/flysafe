require "rails_helper"

RSpec.describe Contact, type: :model do

  describe "ActiveRecord Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:comment) }
  end

  describe "Instance Methods" do
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email) }
    it { should respond_to(:phone_number) }
    it { should respond_to(:comment) }
  end
end
