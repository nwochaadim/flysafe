require "rails_helper"

RSpec.describe LandingController, type: :controller do
  let(:landing_params) { attributes_for(:contact) }

  describe '#index' do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#about' do
    it "renders about template" do
      get :about
      expect(response).to render_template(:about)
    end
  end

  describe '#contact_us' do
    it "renders contact us template" do
      get :contact_us
      expect(response).to render_template(:contact_us)
    end
  end

  describe "#create_feedback" do
    context "when all required parameters are provided" do
      it "redirects to root path" do
        post :create_feedback, landing_params
        expect(response).to redirect_to(root_path)
      end
    end

    context "when all required parameters are not provided" do
      it "re-renders the contact_us template with form errors" do
        post :create_feedback, {}
        expect(response).to render_template(:contact_us)
      end
    end
  end
end
