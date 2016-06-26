class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :gender)
    end
end
