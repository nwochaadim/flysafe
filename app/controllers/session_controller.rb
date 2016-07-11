class SessionController < ApplicationController
  before_action :validate_session, except: [:destroy]

  def new
    @login_style = 'ui large form'
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Log in successful!'
    else
      flash.now.alert = 'Invalid email or password'
      @login_style = 'ui large form error'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Log out successful!'
  end

  private

  def validate_session
    redirect_to root_path if session[:user_id]
  end
end
