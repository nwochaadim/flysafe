require "rails_helper"

RSpec.describe PassengersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/passengers").to route_to("passengers#index")
    end

    it "routes to #new" do
      expect(:get => "/passengers/new").to route_to("passengers#new")
    end

    it "routes to #show" do
      expect(:get => "/passengers/1").to route_to("passengers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/passengers/1/edit").to route_to("passengers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/passengers").to route_to("passengers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/passengers/1").to route_to("passengers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/passengers/1").to route_to("passengers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/passengers/1").to route_to("passengers#destroy", :id => "1")
    end

  end
end
