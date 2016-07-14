module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def root_class
    if request.path == root_path
      "active item"
    else
      "item"
    end
  end

  def first_name
    if current_user
      text_field_tag :first_name, current_user.first_name, placeholder: "E.g John", required: true
    else
      text_field_tag :first_name, nil, placeholder: "E.g John", required: true
    end
 end

  def last_name
    if current_user
      text_field_tag :last_name, current_user.last_name, placeholder: "E.g Doe", required: true
    else
      text_field_tag :last_name, nil, placeholder: "E.g Doe", required: true
    end
  end

  def email
    if current_user
      text_field_tag :email, current_user.email, placeholder: "E.g johndoe@gmail.com", required: true
    else
      text_field_tag :email, nil, placeholder: "E.g johndoe@gmail.com", required: true
    end
  end

  def gender
    if current_user
      select_tag :gender, options_for_select([%w(Male Male), %w(Female Female)], current_user.gender), class: "ui fluid dropdown"
    else
      select_tag :gender, options_for_select([%w(Male Male), %w(Female Female)]), class: "ui fluid dropdown"
    end
  end
end
