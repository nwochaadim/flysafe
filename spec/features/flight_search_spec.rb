require "rails_helper"

RSpec.describe "", type: :feature do
  before{ @flight = create(:flight) }

  feature "Searching a flight" do
    self.use_transactional_fixtures = false
    scenario "with different departure and arrival" do
      it "renders results on same page" do
        
      end
    end


  end

  
end