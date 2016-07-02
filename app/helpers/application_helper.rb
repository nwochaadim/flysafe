require 'faker'
module ApplicationHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end


  def root_class
    if request.path == root_path
      "active item"
    else
      "item"
    end
  end
end
  