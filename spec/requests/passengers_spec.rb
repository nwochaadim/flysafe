require 'rails_helper'

RSpec.describe "Passengers", type: :request do
  describe "GET /passengers" do
    it "works! (now write some real specs)" do
      get passengers_path
      expect(response).to have_http_status(200)
    end
  end
end
