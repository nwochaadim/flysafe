require "rails_helper"

RSpec.describe "Signing Up Process", type: :feature do
  feature "when user fills all required details" do
    scenario "creates user account", js: true do
      visit signup_path
      fill_form_for_sign_up
      expect(page).to have_content("Account Created!")
    end
  end

  feature "when user does not fill all required details correctly" do
    scenario "displays form errors", js: true do
      visit signup_path
      fill_incomplete_form_for_sign_up
      expect(page).to have_content("Email is invalid")
    end
  end
end
