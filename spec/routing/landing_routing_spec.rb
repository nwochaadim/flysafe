require "rails_helper"

RSpec.describe LandingController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/").to route_to("landing#index")
    end

    it "routes to #about" do
      expect(:get => "/about").to route_to("landing#about")
    end

    it "routes to #contact" do
      expect(:get => "/contact").to route_to("landing#contact_us")
    end

  end
end
