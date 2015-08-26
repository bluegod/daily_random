# Preview all emails at http://localhost:3000/rails/mailers/daily_random_mailer
class DailyRandomMailerPreview < ActionMailer::Preview
  def random_mail
   DailyRandomMailer.random_mail("blah@blah.com", "Lorem ipsum dolor sit amet, consectetur adipiscing elit")
  end
end
