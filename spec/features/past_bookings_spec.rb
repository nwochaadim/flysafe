require "rails_helper"

RSpec.describe "Past Bookings", type: :feature do
  before { @booking = create(:booking) }

  feature "when user is logged in" do
    scenario "lists all past bookings", js: true do
      visit login_path
      login_user(@booking.user)
      click_on("Past Bookings")
      expect(page).to have_content(@booking.flight.from_airport.name)
    end
  end
end
