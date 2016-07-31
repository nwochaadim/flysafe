require "rails_helper"

RSpec.describe "Managing Past Bookings", type: :feature do
  let(:booking) { create(:booking) }
  
  feature "when the user enters the correct booking reference", js: true do
    scenario "displays the booking details" do
      visit search_booking_path
      fill_in :reference_number, with: booking.reference_number
      click_on("Search Bookings")
      expect(page).to have_content(booking.flight.from_airport.name)
    end
  end

  feature "when the user enters incorrect booking reference", js: true do
    scenario "displays record not found" do
      visit search_booking_path
      fill_in :reference_number, with: "INVALID"
      click_on("Search Bookings")
      expect(page).to have_content("No record Found")
    end
  end
end
