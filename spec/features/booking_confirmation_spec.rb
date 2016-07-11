require 'rails_helper'

RSpec.describe '', type: :feature do
  before do
    @flight = create(:flight)
    @arriving_airport = create(:arriving_airport)
    @route = create(:route)
    @route.update(flight: @flight)
    @route.update(arriving_airport: @arriving_airport)
  end

  feature 'Booking Confirmation' do
    scenario 'when all details are filled on booking form', js: true do
      visit root_path(anchor: 'booking')
      fill_form_for_flight_search
      sleep 3
      find(:xpath, '//*[@id="progress-container"]/form/table/tfoot/tr/th[2]/input').click
      fill_form_for_booking
      expect(page).to have_content('Your Information')
    end
  end
end
