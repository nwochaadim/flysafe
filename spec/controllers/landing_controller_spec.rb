require 'rails_helper'

RSpec.describe LandingController, type: :controller do
  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #about" do
    it "renders about template" do
      get :about
      expect(response).to render_template(:about)
    end
  end

  describe "GET #contact_us" do
    it "renders contact us template" do
      get :contact_us
      expect(response).to render_template(:contact_us)
    end
  end
end
