class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "Account Created!, you can now login"
       UserMailer.welcome(@user).deliver_now
    else
      render :new
    end
  end

  def past_bookings
    @bookings = User.find(params[:user_id]).bookings
  end


  private
    def user_params
      params.permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :gender)
    end
end
