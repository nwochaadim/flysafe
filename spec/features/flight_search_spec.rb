require "rails_helper"

RSpec.describe "Flight Search", type: :feature do
  before { @flight = create(:flight, :departing, :arriving) }

  feature "when user fills all required information" do
    scenario "displays flights available", js: true do
      visit root_path(anchor: "booking")
      fill_form_for_flight_search(@flight)
      wait_for_ajax
      expect(page).to have_content("Flights Available")
    end
  end

  feature "when user fills all same arrival and departure info" do
    scenario "displays flights available", js: true do
      visit root_path(anchor: "booking")
      fill_incomplete_form_for_flight_search
      wait_for_ajax
      expect(page).to have_content("Error!")
    end
  end
end
