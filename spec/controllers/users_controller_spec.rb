require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:user) }

  describe '#new' do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context "when valid user data is passed" do
      it "creates account and redirects to home page" do
        expect{ post :create, valid_attributes }.to change(User, :count).by(1)
        expect(response).to redirect_to(root_path)
      end
    end

    context "when invalid user data is passed" do
      it "does not create account and renders the new template with errors" do
        expect{ post :create, first_name: nil }.to_not change(User, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#past_bookings' do
    it "renders past bookings template" do
      session[:user_id] = user.id
      post :past_bookings
      expect(response).to render_template(:past_bookings)
    end
  end
end
