class DailyRandomMailer < ApplicationMailer
  def random_mail(email, content)
    @content = content
    mail(to: email, subject: ENV['default_subject'])
  end
end
