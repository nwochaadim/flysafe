require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes){ attributes_for(:user) }

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
    it "renders past bookings template" do
      session[:user_id] = user.id
      post :past_bookings
      expect(response).to render_template(:past_bookings)
    end
  end
end
