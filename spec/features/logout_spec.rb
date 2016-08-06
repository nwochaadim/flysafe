require "rails_helper"

RSpec.describe "Logout process", type: :feature do
  before { @user = create(:user) }

  feature "when user signs out", js: true do
    scenario "deletes user session and redirects to root_path" do
      login_user(@user)
      click_on("Logout")
      visit root_path
      expect(page).to_not have_content(@user.first_name)
    end
  end
end
