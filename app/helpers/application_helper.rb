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

  def show_first_name
    text_field_content(:first_name, current_user)
  end

  def show_last_name
    text_field_content(:last_name, current_user)
  end

  def show_email
    text_field_content(:email, current_user)
  end

  def show_gender
    select_tag_content(:gender, current_user)
  end

  private

  def text_field_content(name, value = nil)
    placeholder = {
      first_name: "E.g John",
      last_name: "E.g Doe",
      email: "johndoe@gmail.com"
    }
    html_params = { placeholder: placeholder[name], required: true }
    value = value ? value.send(name) : nil
    text_field_tag("adult[][#{name}]", value, html_params)
  end

  def select_tag_content(gender = nil)
    html_params = { class: "ui fluid dropdown" }
    options = options_for_select([%w(Male Male), %w(Female Female)], gender)
    select_tag(:gender, options, html_params)
  end
end
