require_relative "concerns/message.rb"
class ApplicationController < ActionController::Base
  include Message
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
