module SessionsHelper
  def check_login
    if flash[:errors]
      "ui large form error"
    else
      "ui large form"
    end
  end
end
