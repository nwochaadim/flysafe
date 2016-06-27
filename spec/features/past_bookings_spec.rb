require "rails_helper"

RSpec.describe "", type: :feature do
  before{ 
    @booking = create(:booking)
    @booking.flight.route.update(arriving_airport: create(:arriving_airport))
  }

  feature "Past Bookings" do
    scenario "when user is logged in", js: true do
      visit login_path
      login_user(@booking.user)
      click_on("Past Bookings")
      expect(page).to have_content(@booking.flight.route.departing_airport.name)
    end
  end
  
end