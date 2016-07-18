class SessionController < ApplicationController
  before_action :validate_session, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: login_success
    else
      flash[:errors] = login_failed
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: logout_success
  end

  private

  def validate_session
    redirect_to root_path if session[:user_id]
  end
end
