require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    { first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.subscriber_number(11),
      password: "secret key",
      password_confirmation: "secret key" }
  end

  describe '#new' do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context "when user's account is created" do
      it "redirect to home page" do
        post :create, valid_attributes
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user's account is not created" do
      it "render new template" do
        post :create, first_name: nil
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#past_bookings' do
    let(:user) { create(:user) }
    it "renders past bookings template" do
      post :past_bookings, user_id: user.id
      expect(response).to render_template(:past_bookings)
    end
  end
end
