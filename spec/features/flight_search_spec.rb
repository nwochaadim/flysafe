require "rails_helper"

RSpec.describe "Flight Search", type: :feature do
  before do
    @flight = create(:flight)
    @arriving_airport = create(:arriving_airport)
    @route = create(:route)
    @route.update(flight: @flight)
    @route.update(arriving_airport: @arriving_airport)
  end

  feature "when user fills all required information" do
    scenario "displays flights available", js: true do
      visit root_path(anchor: "booking")
      fill_form_for_flight_search
      wait_for_ajax
      expect(page).to have_content("Flights Available")
    end
  end
end
