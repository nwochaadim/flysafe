require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  before(:each){ @user = create(:user) }
  it "redirects user to home page if user is logged in" do
    session[:user_id] = @user.id 
    expect(subject.current_user).to eq(@user)
  end
end