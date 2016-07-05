require "rails_helper"

RSpec.describe "", type: :feature do
  before{ 
    @flight = create(:flight)
    @arriving_airport = create(:arriving_airport)
    @route = create(:route)
    @route.update(flight: @flight)
    @route.update(arriving_airport: @arriving_airport)
  }

  feature "Searching a flight" do
    scenario "with different departure and arrival airport and a valid date", js: true do
      visit root_path(anchor: "booking")
      fill_form_for_flight_search
      expect(page).to have_content('Flights Available')
    end
  end

  
end