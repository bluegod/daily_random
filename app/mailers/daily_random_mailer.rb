class DailyRandomMailer < ApplicationMailer
  def random_mail(email, content, token)
    @content = content
    @token = token
    @email = email
    mail(to: email, subject: ENV['default_subject'])
  end
end
