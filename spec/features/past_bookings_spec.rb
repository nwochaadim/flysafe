require "rails_helper"

RSpec.describe "Past Bookings", type: :feature do
  before do
    @booking = create(:booking)
    @booking.flight.route.update(arriving_airport: create(:arriving_airport))
  end

  feature "when user is logged in" do
    scenario "lists all past bookings", js: true do
      visit login_path
      login_user(@booking.user)
      click_on("Past Bookings")
      expect(page).to have_content(@booking.flight.route.departing_airport.name)
    end
  end
end
