require 'daily_random_mailer'

class DailySender
  def self.perform(job)
    DailyRandomMailer.random_mail(job.data['email'], job.data['content'], job.data['token']).deliver
  end
end