require "rails_helper"

RSpec.describe "", type: :feature do
  before{ @user = create(:user) }

  feature "Signing in", js: true do
    self.use_transactional_fixtures = false
    scenario "with correct credentials" do
      visit login_path
      fill_in 'email', with: @user.email
      fill_in 'password', with: "secret_key"
      click_button 'Login'
      expect(page).to have_content(@user.first_name)
    end

    scenario "with incorrect details" do
      visit login_path
      fill_in 'email', with: " "
      fill_in 'password', with: " "
      click_button 'Login'
      expect(page).to have_content('Invalid email or password')
    end
  end

  
end