require "rails_helper"

RSpec.describe "Signing in Process", type: :feature do
  before { @user = create(:user) }

  feature "user login", js: true do
    scenario "with correct credentials" do
      login_user(@user)
      expect(page).to have_content(@user.first_name)
    end

    scenario "with incorrect details" do
      visit login_path
      fill_in "email", with: "invalid email"
      fill_in "password", with: "invalid email"
      page.execute_script("$('.ui.fluid.large.teal.submit.button').click()")
      expect(page).to have_content("Invalid email or password")
    end
  end
end
