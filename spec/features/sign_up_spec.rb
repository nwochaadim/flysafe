require "rails_helper"

RSpec.describe "Signing Up Process", type: :feature do
  feature "when user enters correct credentials" do
    scenario "creates user account", js: true do
      visit signup_path
      fill_form_for_sign_up
      expect(page).to have_content("Account Created!")
    end
  end
end
