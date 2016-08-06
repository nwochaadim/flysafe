require "rails_helper"

RSpec.describe SessionController, type: :controller do
  let(:user) { create(:user) }

  describe '#new' do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context "as an authenticated user" do
      it "redirects to root path" do
        post :create, email: user.email, password: "secret_key"
        expect(response).to redirect_to(root_path)
      end
    end

    context "as an unauthenticated user" do
      it "renders the new template, displaying errors" do
        post :create, email: "", password: ""
        expect(response).to render_template(:new)
        expect(flash[:errors]).to eq("Invalid email or password")
      end
    end
  end

  describe '#destroy' do
    it "destroys users sessions and redirects to the home page" do
      get :destroy
      expect(session[:user_id]).to eq(nil)
      expect(response).to redirect_to(root_path)
    end
  end
end
