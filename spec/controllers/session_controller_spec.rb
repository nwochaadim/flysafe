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
      before { post :create, email: "", password: "" }
      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "notifies the user of an invalid email or password" do
        expect(flash[:errors]).to eq("Invalid email or password")
      end
    end
  end

  describe '#destroy' do
    before { get :destroy }
    it "destroys users sessions" do
      expect(session[:user_id]).to eq(nil)
    end

    it "redirects user to login page" do
      expect(response).to redirect_to(root_path)
    end
  end
end
