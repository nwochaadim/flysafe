require "rails_helper"

RSpec.describe "", type: :feature do
  before{ 
    @flight = create(:flight)
    create(:arriving_airport)
  }

  feature "Booking Confirmation" do
    scenario "when all details are filled on booking form", js: true do
      visit root_path(anchor: "booking")
      fill_form_for_flight_search
      click_button 'Book Now'
      fill_form_for_booking
      expect(page).to have_content("Your Information")
    end
  end
  
end