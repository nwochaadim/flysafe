require "rails_helper"

RSpec.describe "", type: :feature do
  before{ @user = create(:user) }

  feature "Logging out user", js: true do
    scenario "with correct credentials" do
      login_user(@user)
      click_on("Logout")
      visit root_path
      expect(page).to_not have_content(@user.first_name)
    end
  end

end