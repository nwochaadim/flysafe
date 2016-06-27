module LoginHelper
  def login_user(user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: "secret_key"
    click_button 'Login'
  end
end