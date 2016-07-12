require "rails_helper"

RSpec.describe SessionController, type: :routing do
  describe "routing" do
    it 'routes to #new' do
      expect(post: "/session").to route_to('session#create')
    end
  end
end
