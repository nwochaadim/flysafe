require "rails_helper"

RSpec.describe "Managing Past Bookings", type: :feature do
  before do
    @booking = create(:booking)
    @booking.flight.route.update(arriving_airport: create(:arriving_airport))
  end
  feature "when the user enters the correct booking reference", js: true do
    scenario "displays the booking details" do
      visit search_booking_path
      fill_in :reference_number, with: @booking.reference_number
      click_on("Search Bookings")
      expect(page).to have_content(@booking.flight.route.departing_airport.name)
    end
  end
end
