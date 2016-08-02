require 'rails_helper'

RSpec.describe 'Booking Confirmation', type: :feature do
  before(:each){ @flight = create(:flight, :departing, :arriving) }

  context "when user is registered and logged in" do
    before(:each) do 
      @user = create(:user)
      login_user(@user)
      fill_form_for_flight_search(@flight)
      wait_for_ajax
      choose('selected_flight_1')
      find(
          :xpath,
          '//*[@id="progress-container"]/form/table/tfoot/tr/th[2]/input'
          ).click
    end

    feature 'all booking information is filled' do
      scenario 'displays booking information', js: true do
        fill_form_for_booking
        wait_for_ajax
        expect(page).to have_content('Your Booking Information')
      end
    end

    feature 'all booking information is not filled' do
      scenario 'does not display booking information', js: true do
        fill_incomplete_form_for_booking
        wait_for_ajax
        expect(page).to_not have_content('Your Booking Information')
      end
    end

  end

  context "when user is not registered" do
    before(:each) do
      visit root_path
      fill_form_for_flight_search(@flight)
      wait_for_ajax
      choose('selected_flight_1')
      find(
          :xpath,
          '//*[@id="progress-container"]/form/table/tfoot/tr/th[2]/input'
          ).click
    end

    feature 'all booking information is filled' do
      scenario 'displays booking information', js: true do
        fill_form_for_booking
        wait_for_ajax
        expect(page).to have_content('Your Booking Information')
      end
    end

    feature 'all booking information is not filled' do
      scenario 'does not display booking information', js: true do
        fill_incomplete_form_for_booking
        wait_for_ajax
        expect(page).to_not have_content('Your Booking Information')
      end
    end

  end
end