require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  before { @user = create(:user) }

  describe "#current_user" do
    context "when user is logged in" do
      it "return the currently logged in user" do
        session[:user_id] = @user.id
        expect(subject.current_user).to eq(@user)
      end
    end

    context "when user is logged out" do
      it "returns nil for current user" do
        expect(subject.current_user).to eq(nil)
      end
    end
  end
end
