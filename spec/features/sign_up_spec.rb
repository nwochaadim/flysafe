require "rails_helper"

RSpec.describe "", type: :feature do

  feature "Signing Up" do
    scenario "with all required details filled on form", js: true do
      visit signup_path
      fill_form_for_sign_up
      expect(page).to have_content("Account Created!")
    end
  end
  
end