require "rails_helper"

RSpec.describe "", type: :feature do
  before{ @booking = create(:booking) 
    @booking.flight.route.update(arriving_airport: create(:arriving_airport))
  }
  feature "Managing Past Bookings", js: true do
    scenario "when correct booking reference number is entered" do
      visit search_booking_path
      fill_in :reference_number, with: @booking.reference_number
      click_on("Search Bookings")
      expect(page).to have_content(@booking.flight.route.departing_airport.name)
    end
  end
  
end