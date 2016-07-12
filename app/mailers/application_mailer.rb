class ApplicationMailer < ActionMailer::Base
  default from: "noreply@fly-safe.herokuapp.com"
  layout "mailer"
end
