class DailySender
  def self.perform(job)
    DailyRandomMailer.random_mail(job.data[:email], job.data[:quote]).deliver
  end
end