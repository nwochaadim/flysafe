require "rails_helper"

RSpec.describe AirportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/airports").to route_to("airports#index")
    end

    it "routes to #new" do
      expect(:get => "/airports/new").to route_to("airports#new")
    end

    it "routes to #show" do
      expect(:get => "/airports/1").to route_to("airports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/airports/1/edit").to route_to("airports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/airports").to route_to("airports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/airports/1").to route_to("airports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/airports/1").to route_to("airports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/airports/1").to route_to("airports#destroy", :id => "1")
    end

  end
end
