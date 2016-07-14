require "rails_helper"

RSpec.describe "Booking Confirmation", type: :feature do
  before do
    @flight = create(:flight)
    @arriving_airport = create(:arriving_airport)
    @route = create(:route)
    @route.update(flight: @flight)
    @route.update(arriving_airport: @arriving_airport)
  end

  feature "when the user fills required details" do
    scenario "displays booking information", js: true do
      visit root_path(anchor: "booking")
      fill_form_for_flight_search
      sleep 3
      find(:xpath, '//*[@id="progress-container"]/form/table/tfoot/tr/th[2]/input').click
      sleep 2
      fill_form_for_booking
      expect(page).to have_content("Your Information")
    end
  end
end
