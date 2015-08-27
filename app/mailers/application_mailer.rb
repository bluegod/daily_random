class ApplicationMailer < ActionMailer::Base
  default from: "daily@localhost.com"
  layout 'mailer'
end
